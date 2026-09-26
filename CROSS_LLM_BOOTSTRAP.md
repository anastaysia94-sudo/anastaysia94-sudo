# Cross-LLM Bootstrap — SmartPickShop

Updated: 2026-09-25 America/Los_Angeles

## Purpose

This is the portable entrypoint for moving SmartPickShop work between ChatGPT accounts, other LLMs, coding agents, and back again without relying on one chat history.

## Resume protocol

1. Read this file.
2. Read `PORTFOLIO_CONTINUITY.md`.
3. Read `portfolio/REPO_MAP.json` for canonical repositories and latest recorded checkpoints.
4. Read `portfolio/PROJECTS.json` for the P001–P161 portfolio inventory.
5. Identify the target project and open its canonical repository.
6. In that repository, read `AI_HANDOFF.md`, `STATUS.md`, `NEXT_ACTIONS.md`, `DECISIONS.md`, recent commits, open PRs/issues, and current CI before changing anything.
7. Treat historical assistant/chat claims as context only. Executable tests, repository state, connected-app records, and current artifacts outrank narrative.
8. Continue the smallest concrete unfinished execution block.
9. Before stopping, update the project handoff/status files and the account-wide continuity records so the next LLM does not repeat discovery.

## Private Google Drive entrypoint

On an authorized Google Drive connection, search by exact title:

**00 — LLM CONTINUITY — START HERE — SmartPickShop**

Then use the current master ledger titled:

**Master Project Ledger — SmartPickShop — CURRENT — 2026-09-25**

The Drive START HERE document owns the private asset/file index. Public GitHub intentionally does not store Drive file IDs or private account details.

## Latest high-movement repository checkpoints

- `EGM4000-Android` — `59f3f3f7c8b9c4586acdb9eb86661c58c79d7c88` — authorized non-monetary acceptance boundary documented.
- `cashh-radar` — `4367dc613fd425e2c2bf1cdc37fc06e0c22b5068` — production-mobile acceptance waits bounded for navigation/body/service-worker checks.
- `smartpickshop-trend-lab` — `0a8949028aa54f968979078a3ca414b97b703cc6` — development loopback/private-host authentication handling adjusted.
- `founder-os` — `d88fd1428bf4ff4102e95fa0fa84fe8d0ed14b25` — obsolete Four-Offer Railway deploy workflow retired.
- `AudioHardcore` — `e8f3d9e7092278d2066c5fa523a3e423eae7b77e` — Resonance bridge generation workflow corrected.
- `doubletap-rewards` — `3a4368850edf400d7a482fa537b6010e20244b9f` — real-device Android debug install/launch acceptance recorded.

These are source checkpoints, not blanket claims that every deployment or CI workflow is currently green.

## Missing dedicated repositories

Ten projects have prebuilt seed packs under `repo-seeds/`:

- smartpickshop-project-continuity
- corporate-hieroglyphics-lnc
- promotion-engine
- remote-career-command-center
- wastebounty
- ptedboss
- sugarrush-slasher
- fulfillment-checker
- ai-nexus
- micro-snipe-board

The connected GitHub tool currently cannot create repositories. `scripts/bootstrap_missing_repos.ps1` creates them through an authenticated GitHub CLI when repository-creation permission is available. Until then, the seed packs are the durable source of truth for those repo handoffs.

## Return-to-ChatGPT protocol

When returning here from another LLM:

1. Make sure that LLM saved code/content changes to the canonical repository or authorized Drive file.
2. Have it update `STATUS.md`, `NEXT_ACTIONS.md`, and `DECISIONS.md` with concrete evidence and exact commit/file references.
3. If a project has no dedicated repo, update its staged seed pack and the master ledger instead.
4. In the new ChatGPT conversation, provide the target project name/ID and instruct ChatGPT to start from this bootstrap plus the latest repository/Drive state.
5. Do not paste secrets into handoff prompts. Reconnect apps/services through their normal authorization flows.

## Evidence contract

Do not mark work COMPLETE from prose alone when direct verification is possible. Record changed files, commit SHA, build/test result, deployment or app status when applicable, exact blocker, and rollback path for risky changes.

## Safety / authorization

For EGM4000 and F.S.A., acceptance is limited to owned or explicitly authorized non-cash environments, synthetic/authorized telemetry, and internal test accounts. A live third-party gambling-style service, real-money account, or bypass of age/identity/platform controls is not a release requirement.

## Security

Never commit credentials, API keys, passwords, customer secrets, private personal information, or private Drive identifiers to public GitHub. Treat any public test credential as disposable test-only data and never reuse it for production.
