# One-time setup for the already-installed 21-repository backup workflow.
# Must be run on your own Windows computer after GitHub CLI and rclone are installed.
# It never deletes artifacts, starts a paid action, or enables recurring backups.
[CmdletBinding()]
param(
  [string]$Owner = 'anastaysia94-sudo',
  [string]$DriveRemote = 'gdrive',
  [string]$DriveFolder = 'GitHub-Backups',
  [string]$PilotRepository = 'anastaysia94-sudo',
  [switch]$RunPilot
)
$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

function Require-Command([string]$Name) {
  if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
    throw "$Name is not installed or not in PATH. Install it, then rerun this script."
  }
}
Require-Command 'gh'
Require-Command 'rclone'

$loginResult = & gh api user --jq '.login' 2>$null
$login = [string]($loginResult | Select-Object -First 1)
$login = $login.Trim()
if ($LASTEXITCODE -ne 0 -or $login -ne $Owner) {
  throw "Please run 'gh auth login' for the $Owner GitHub account first; connected GitHub login is '$login'."
}

# Never print tokens or the rclone configuration. Require one dedicated Drive remote.
$allRemotes = @(& rclone listremotes 2>$null)
if ($LASTEXITCODE -ne 0 -or ($allRemotes -notcontains "${DriveRemote}:")) {
  throw "No rclone remote named '$DriveRemote'. Run 'rclone config' and authorize your intended Google Drive account first."
}
& rclone lsd "${DriveRemote}:${DriveFolder}" | Out-Null
if ($LASTEXITCODE -ne 0) { throw "Cannot access ${DriveRemote}:${DriveFolder}. Verify that the rclone account is your intended Google Drive account." }

# Extract just the selected remote to avoid disclosing other rclone account tokens.
# The selected remote must be a Google Drive remote, not crypt/alias to another remote.
$configOutput = @(& rclone config file)
if ($LASTEXITCODE -ne 0) { throw 'rclone config file failed' }
$configPath = ($configOutput | Select-Object -Last 1).Trim().Trim('"')
if (-not (Test-Path -LiteralPath $configPath)) {
  throw "Cannot read the rclone config path. Rclone output: $($configOutput -join ' | ')"
}
$ini = [IO.File]::ReadAllText($configPath)
$escaped = [regex]::Escape($DriveRemote)
$match = [regex]::Match($ini, "(?ms)^\[$escaped\]\s*\r?\n.*?(?=^\[|\z)")
if (-not $match.Success) { throw "rclone config section '$DriveRemote' was not found" }
$remoteSection = $match.Value
if ($remoteSection -notmatch '(?m)^type\s*=\s*drive\s*$') {
  throw 'The selected remote must be type = drive. Use a dedicated Google Drive remote for this installation.'
}
if ($remoteSection -notmatch '(?m)^token\s*=') {
  throw 'The remote has no OAuth token. Finish the interactive rclone config authorization first.'
}
$encodedConfig = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($remoteSection))

$raw = & gh repo list $Owner --limit 100 --json nameWithOwner,isArchived
if ($LASTEXITCODE -ne 0) { throw 'Cannot list GitHub repositories' }
$repos = @($raw | ConvertFrom-Json | Where-Object { -not $_.isArchived } | Sort-Object nameWithOwner)
if ($repos.Count -lt 1) { throw 'No active GitHub repositories were returned' }
Write-Host "Preparing $($repos.Count) repositories for $Owner. Automatic schedules/deletions remain DISABLED."

$errors = @()
foreach ($r in $repos) {
  $repo = [string]$r.nameWithOwner
  Write-Host "Configuring $repo"
  try {
    # gh reads the encoded OAuth config from stdin; do not expose the value in CLI arguments.
    $encodedConfig | & gh secret set RCLONE_CONFIG_B64 --repo $repo
    if ($LASTEXITCODE -ne 0) { throw 'Setting Actions secret failed' }
    & gh variable set DRIVE_BACKUP_PATH --repo $repo --body "${DriveRemote}:${DriveFolder}"
    if ($LASTEXITCODE -ne 0) { throw 'Setting Drive path failed' }
    & gh variable set DRIVE_BACKUP_READY --repo $repo --body 'false'
    if ($LASTEXITCODE -ne 0) { throw 'Disabling schedule failed' }
    & gh variable set BACKUP_DELETE_ENABLED --repo $repo --body 'false'
    if ($LASTEXITCODE -ne 0) { throw 'Disabling deletion failed' }
    Write-Host "  Credentials installed; automatic operations still disabled."
  } catch {
    Write-Warning "${repo}: $($_.Exception.Message)"
    $errors += "$repo - $($_.Exception.Message)"
  }
}
$encodedConfig = $null
$remoteSection = $null
$ini = $null

if ($RunPilot -and $errors.Count -eq 0) {
  $pilot = "$Owner/$PilotRepository"
  Write-Host "Triggering BACKUP-ONLY pilot in $pilot (no deletion)."
  & gh workflow run 'backup-to-drive.yml' --repo $pilot --ref main --raw-field delete_after_backup=false --raw-field min_age_days=7
  if ($LASTEXITCODE -ne 0) { throw 'Pilot workflow could not be triggered; no deletion attempted.' }
  Write-Host "Open https://github.com/$pilot/actions to review the resulting upload and checksums."
}
if ($errors.Count -gt 0) {
  Write-Warning "$($errors.Count) repository setup failures. None will be enabled for scheduled cleanup by this script."
  $errors | ForEach-Object { Write-Warning $_ }
  exit 1
}
Write-Host 'Set up completed. Automatic operation and deletion remain disabled.'
Write-Host 'After the Drive backup pilot actually passes, opt in per repository with:'
Write-Host 'gh variable set DRIVE_BACKUP_READY --repo OWNER/REPO --body true'
Write-Host 'For verified weekly artifact deletion, additionally:'
Write-Host 'gh variable set BACKUP_DELETE_ENABLED --repo OWNER/REPO --body true'