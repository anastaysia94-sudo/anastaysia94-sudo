# SmartPickShop Portfolio Continuity

Updated: 2026-09-25 23:00 (America/Los_Angeles)

## Purpose

This repository is the discovery point for continuing SmartPickShop work from any LLM account, coding agent, or human workstation. The GitHub record should be treated as the portable source of truth for repository locations, project IDs, handoff rules, and unresolved repo gaps.

## Continuity rules

1. Start with `portfolio/PROJECTS.json` for the account-wide inventory.
2. Use stable project IDs (P001–P161) when a project has one.
3. Existing repositories remain canonical for their current source until an explicit migration is completed.
4. Do not duplicate a module into a new repository merely because it has a name. Create a new repo only when the workstream is independently buildable, shippable, or maintainable.
5. Current ownership correction: Sales OS belongs with Cashh Radar, not Founder Dynasty OS. Founder Console remains a module of F.S.A. unless explicitly separated later.
6. Historical assistant claims are evidence to verify, not proof that a build, deployment, customer action, or launch is currently working.
7. Record every important change with: what changed, why, verification evidence, remaining blockers, and rollback path when relevant.
8. Never put credentials, API keys, passwords, customer secrets, or private personal information in a public repository.

## Existing GitHub coverage

- `anastaysia94-sudo/ai-bridge` — P034 AI Bridge
- `anastaysia94-sudo/Anarchy-LLM` — Anarchy LLM / prompt-system experiments
- `anastaysia94-sudo/AudioHardcore` — P036 Resonance Digital Audio OS / Collector
- `anastaysia94-sudo/cashh-radar` — P010 Cashh Radar + P004 Sales OS + related sales tooling
- `anastaysia94-sudo/doubletap-rewards` — P050 DoubleTap Rewards OS
- `anastaysia94-sudo/dumpsteratlas` — P041 Dumpster Atlas
- `anastaysia94-sudo/EGM4000-Android` — P045 EGM4000 / EduGameMaster4000
- `anastaysia94-sudo/Firek-clone` — Related fish-shooter experiment
- `anastaysia94-sudo/fish-shooter-arcade` — P046 Fish Shooter Arcade / F.S.A. + P047 Founder Console module
- `anastaysia94-sudo/founder-os` — P002 Founder Dynasty OS + P016 Four-Offer Launch source currently located here
- `anastaysia94-sudo/human-operating-system-institute` — P039 HOSI
- `anastaysia94-sudo/impound-ransom` — Impound Ransom project
- `anastaysia94-sudo/manila` — Manila project
- `anastaysia94-sudo/same-beat` — P037 Same-Beat
- `anastaysia94-sudo/san-jose-prospecting-pwa` — Santa Clara / San Jose prospecting PWA
- `anastaysia94-sudo/smartpickshop-trend-lab` — P020 SmartPickShop Trend Lab + P021 spec
- `anastaysia94-sudo/snarkyhowtos` — P054 Snarky How-Tos; P053 Oops Academy can remain sibling content until independently built
- `anastaysia94-sudo/anastaysia94-sudo.github.io` — Portfolio / Field OS pages
- `anastaysia94-sudo/anastaysia94-sudo` — Profile + portfolio continuity index

## Repository gaps that are appropriate to split

- **smartpickshop-project-continuity** — P009 Master project register / Atlas / Wiki. Create as the canonical cross-account continuity repository when repo-creation access is available.
- **corporate-hieroglyphics-lnc** — P007 Corporate Hieroglyphics / LNC. Durable notebook/product system with recurring definitions, printable assets, and workflows.
- **promotion-engine** — P018 Promotion Engine. Independent promotion/distribution command center with saved research packs and site/workspace work.
- **remote-career-command-center** — P022 Remote Career Command Center. Long-running packaged job-search toolkit/workspace with repeatable research and application assets.
- **wastebounty** — P025 WASTEBounty. Active service/product workstream with methodology, savings register, partner outreach, and client process.
- **ptedboss** — P035 PTEDBoss / PartyTeller. Near-release mobile product with APK/testing history and a named intended user.
- **sugarrush-slasher** — P049 SugarRush Slasher. Game project with source/build recovery and APK testing as the next concrete gate.
- **fulfillment-checker** — P123 $0-Upfront Fulfillment Checker. Recovered Shopify-installable package with formulas and production-install validation still needed.
- **ai-nexus** — P125 AI Nexus. Cross-AI context/handoff infrastructure distinct enough to deserve a dedicated source-of-truth repo.
- **micro-snipe-board** — P140 Craigslist MICRO-SNIPE board. Active private mobile-first resale-ranking tool/workflow with defined filters and ranking behavior.

## Projects that should NOT be split yet

Concept-only ideas, one-off support cases, repair tasks, artwork variants, modules already owned by a parent product, and items with unrecovered source stay indexed in `portfolio/PROJECTS.json` until there is enough independent implementation to justify a repository.

Notable examples: Sales OS stays with Cashh Radar; Founder Console stays with F.S.A.; Four-Offer Launch remains where its current source lives until a deliberate migration; Oops Academy can stay alongside Snarky How-Tos until it has a distinct production pipeline; PokéScan X, Instant Decision Bot, Money Forge AI X, and other concept-heavy items should get repos after source or a runnable MVP is recovered.

## Resume protocol for another LLM/account

1. Read `CROSS_LLM_BOOTSTRAP.md`, then this file and `portfolio/PROJECTS.json`.
2. Identify the target project ID and canonical repository.
3. Read that repository's README, status/handoff files, open PRs/issues, recent commits, and CI before changing code.
4. Separate **verified current state** from historical claims.
5. Continue the smallest concrete unfinished execution block.
6. Save a handoff note before stopping so the next model does not repeat discovery work.
7. For private files/assets, use the authorized Google Drive entrypoint titled `00 — LLM CONTINUITY — START HERE — SmartPickShop`; do not copy private Drive IDs into public GitHub.

## Canonical inventory provenance

The project inventory was synchronized from **Master Project Register — SmartPickShop**, updated September 23, 2026, then reconciled against the GitHub repositories visible to the authenticated account on September 25, 2026.

## Portability pack status

All 19 currently accessible repositories have durable continuity files. Ten repository-gap projects have prebuilt seed packs under `repo-seeds/`, and `scripts/bootstrap_missing_repos.ps1` can create their private repositories once an authenticated GitHub CLI with repository-creation permission is available. The account-wide portable entrypoint is `CROSS_LLM_BOOTSTRAP.md`.
