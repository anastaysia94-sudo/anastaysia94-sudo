# GitHub → Google Drive Backup: deployment record

Status recorded: 2026-10-10 UTC. Owner: `anastaysia94-sudo`.

The workflow `.github/workflows/backup-to-drive.yml` and script `scripts/backup-to-drive.sh` were installed in **21 accessible repositories** owned by this account. The workflow:
- is manually runnable but requires `RCLONE_CONFIG_B64` for Google Drive OAuth;
- skips every scheduled job unless `DRIVE_BACKUP_READY=true` is deliberately set for that repository;
- defaults to `delete_after_backup=false`;
- permits scheduled artifact deletion only if `BACKUP_DELETE_ENABLED=true` is explicitly set;
- checks SHA-256 of each uploaded backup by re-reading it from Drive before any artifact deletion;
- never deletes Git code, commits, branches, GitHub Releases, workflows, Packages, or caches.

The connected Drive account was used to create a `GitHub-Backups` folder. Three GitHub Actions artifact ZIPs were independently copied to Drive and verified by byte-for-byte readback: one Firek-clone artifact and two doubletap-rewards artifacts, totaling 29,910,292 bytes. **No GitHub artifact was deleted.**

**End-to-end automatic acceptance is pending OAuth authorization on a trusted device.** GitHub Actions secrets cannot be set through the connected GitHub API actions available here. Use `scripts/setup-anastaysia94.ps1` from Windows PowerShell after `gh auth login` and `rclone config` to install the encrypted Actions secret and safe variables on all accessible repositories. The setup script intentionally leaves scheduled backup and deletion disabled. Run one backup-only pilot first; inspect the workflow output and Google Drive copies before any opt-in.

Note: full historic repositories, GitHub Issues/PRs/Packages, existing cache objects, and all historic artifacts have **not** been fully migrated in the connector session. Storage percentage remains unverified; previously accrued GitHub storage usage is not reversible merely by deleting artifacts. Use within GitHub and Google free tier limits only.
