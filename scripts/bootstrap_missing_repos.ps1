# Requires GitHub CLI to be installed and authenticated with repo-create permission.
# This script intentionally does not contain credentials.

$owner = "anastaysia94-sudo"
$repos = @(
  "smartpickshop-project-continuity",
  "corporate-hieroglyphics-lnc",
  "promotion-engine",
  "remote-career-command-center",
  "wastebounty",
  "ptedboss",
  "sugarrush-slasher",
  "fulfillment-checker",
  "ai-nexus",
  "micro-snipe-board"
)

foreach ($repo in $repos) {
  gh repo view "$owner/$repo" *> $null
  if ($LASTEXITCODE -eq 0) {
    Write-Host "EXISTS  $owner/$repo"
    continue
  }
  gh repo create "$owner/$repo" --private --description "SmartPickShop project continuity repository. See anastaysia94-sudo/anastaysia94-sudo for canonical portfolio mapping."
  if ($LASTEXITCODE -ne 0) {
    throw "Failed to create $owner/$repo"
  }
  Write-Host "CREATED $owner/$repo"
}

Write-Host "Repository creation pass complete. Seed each repo from portfolio/REPO_GAPS.md and PORTFOLIO_CONTINUITY.md."
