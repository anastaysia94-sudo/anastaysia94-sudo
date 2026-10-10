#!/usr/bin/env bash
# Cost-free Moto G / Termux controller for GitHub -> Google Drive archives.
# Does not start GitHub-hosted Actions unless you deliberately do that separately.
set -Eeuo pipefail
umask 077
OWNER='anastaysia94-sudo'
REMOTE='gdrive:GitHub-Backups'
REPOS=(Firek-clone manila impound-ransom EGM4000-Android AudioHardcore human-operating-system-institute cashh-radar founder-os same-beat fish-shooter-arcade san-jose-prospecting-pwa Anarchy-LLM doubletap-rewards snarkyhowtos dumpsteratlas ai-bridge smartpickshop-trend-lab anastaysia94-sudo anastaysia94-sudo.github.io grokbot-workspace SmartPickShop)
fail(){ printf 'ERROR: %s\n' "$*" >&2; exit 1; }
need(){ command -v "$1" >/dev/null 2>&1 || fail "Missing $1; install with pkg install -y git git-lfs gh rclone jq curl unzip tar coreutils"; }
for cmd in gh rclone git jq curl unzip tar base64; do need "$cmd"; done
[[ "$(gh api user --jq .login 2>/dev/null)" == "$OWNER" ]] || fail "Authenticate as $OWNER: gh auth login --web -p https -s repo,workflow"
rclone lsf "$REMOTE" --dirs-only >/dev/null || fail "Google Drive not ready at $REMOTE. Run rclone config and select Google account anastaysia94@gmail.com."
MODE="${1:-help}"
resolve_repo(){
  local requested="${1:-}" name
  for name in "${REPOS[@]}"; do [[ "$name" == "$requested" ]] && return 0; done
  fail "Repository not on the verified 21-repo allowlist: $requested"
}
backup(){
  local name="$1" delete="$2" temp token status
  resolve_repo "$name"
  temp="$(mktemp -d)"
  trap 'rm -rf "$temp"' RETURN
  gh api "repos/$OWNER/$OWNER/contents/scripts/backup-to-drive.sh" --jq .content | base64 --decode > "$temp/backup-to-drive.sh"
  bash -n "$temp/backup-to-drive.sh"
  token="$(gh auth token)"
  printf 'Running phone-local %s for %s\n' "$(if [[ "$delete" == true ]]; then echo verified-cleanup; else echo backup-only; fi)" "$name"
  if GH_TOKEN="$token" GITHUB_REPOSITORY="$OWNER/$name" DRIVE_DESTINATION="$REMOTE" MIN_AGE_DAYS=7 DELETE_AFTER_BACKUP="$delete" BACKUP_LFS=true bash "$temp/backup-to-drive.sh"; then
    echo "SUCCESS: $name"
  else
    status=$?; echo "FAILED (no further repository work): $name (exit $status)" >&2; return "$status"
  fi
}
case "$MODE" in
  check)
    echo "GitHub: $(gh api user --jq .login)"
    echo "Drive remote: $REMOTE (accessible)"
    echo "Repositories: ${#REPOS[@]}"
    ;;
  install-secrets)
    conf="${RCLONE_CONFIG:-$HOME/.config/rclone/rclone.conf}"
    [[ -s "$conf" ]] || fail "Missing config file: $conf"
    read -r -p 'Type CONFIGURE to add the Drive secret to all 21 repositories (no workflows will run): ' answer
    [[ "$answer" == CONFIGURE ]] || fail 'Cancelled'
    for name in "${REPOS[@]}"; do
      repo="$OWNER/$name"
      base64 "$conf" | tr -d '\n' | gh secret set RCLONE_CONFIG_B64 --repo "$repo"
      gh variable set DRIVE_BACKUP_PATH --repo "$repo" --body "$REMOTE"
      gh variable set DRIVE_BACKUP_READY --repo "$repo" --body false
      gh variable set BACKUP_DELETE_ENABLED --repo "$repo" --body false
      printf 'Configured safely: %s\n' "$repo"
    done
    echo 'Secrets installed. Scheduling and deletion are still disabled.'
    ;;
  backup)
    [[ -n "${2:-}" ]] || fail 'Usage: bash setup-termux-backups.sh backup REPOSITORY-NAME'
    backup "$2" false
    ;;
  cleanup)
    [[ -n "${2:-}" ]] || fail 'Usage: bash setup-termux-backups.sh cleanup REPOSITORY-NAME'
    read -r -p 'Type VERIFIED-CLEANUP to archive and delete eligible GitHub artifacts only after SHA-256 verification: ' answer
    [[ "$answer" == VERIFIED-CLEANUP ]] || fail 'Cancelled'
    backup "$2" true
    ;;
  backup-all)
    for name in "${REPOS[@]}"; do backup "$name" false; done
    ;;
  cleanup-all)
    read -r -p 'Type VERIFIED-CLEANUP-ALL to back up and clean eligible artifacts across ALL 21 repos: ' answer
    [[ "$answer" == VERIFIED-CLEANUP-ALL ]] || fail 'Cancelled'
    for name in "${REPOS[@]}"; do backup "$name" true; done
    ;;
  *)
    cat <<'HELP'
Phone setup:
  pkg update && pkg upgrade -y
  pkg install -y git git-lfs gh rclone jq curl unzip tar coreutils
  gh auth login --web -p https -s repo,workflow
  rclone config    # create gdrive remote for anastaysia94@gmail.com
Commands:
  bash setup-termux-backups.sh check
  bash setup-termux-backups.sh backup Firek-clone       # backup-only pilot, no deletion
  bash setup-termux-backups.sh cleanup Firek-clone      # opt-in backup + verify + delete old disposable artifacts
  bash setup-termux-backups.sh backup-all               # sequential phone-only backup
  bash setup-termux-backups.sh cleanup-all              # explicit confirmation required
  bash setup-termux-backups.sh install-secrets          # optional for future GitHub Actions; does not enable runs
Never share rclone.conf, access tokens, or printed OAuth credentials.
HELP
    ;;
esac
