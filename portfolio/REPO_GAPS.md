# Repository Gap Plan

Updated: 2026-09-25

The connected GitHub integration can modify existing repositories but does not currently expose repository creation. The Windows workstation has Git installed, but no non-interactive stored GitHub credential is available. Therefore these repos are approved **targets**, not falsely claimed creations.

| Proposed repository | Project | Why it deserves its own repo |
|---|---|---|
| `smartpickshop-project-continuity` | P009 Master project register / Atlas / Wiki | Create as the canonical cross-account continuity repository when repo-creation access is available. |
| `corporate-hieroglyphics-lnc` | P007 Corporate Hieroglyphics / LNC | Durable notebook/product system with recurring definitions, printable assets, and workflows. |
| `promotion-engine` | P018 Promotion Engine | Independent promotion/distribution command center with saved research packs and site/workspace work. |
| `remote-career-command-center` | P022 Remote Career Command Center | Long-running packaged job-search toolkit/workspace with repeatable research and application assets. |
| `wastebounty` | P025 WASTEBounty | Active service/product workstream with methodology, savings register, partner outreach, and client process. |
| `ptedboss` | P035 PTEDBoss / PartyTeller | Near-release mobile product with APK/testing history and a named intended user. |
| `sugarrush-slasher` | P049 SugarRush Slasher | Game project with source/build recovery and APK testing as the next concrete gate. |
| `fulfillment-checker` | P123 $0-Upfront Fulfillment Checker | Recovered Shopify-installable package with formulas and production-install validation still needed. |
| `ai-nexus` | P125 AI Nexus | Cross-AI context/handoff infrastructure distinct enough to deserve a dedicated source-of-truth repo. |
| `micro-snipe-board` | P140 Craigslist MICRO-SNIPE board | Active private mobile-first resale-ranking tool/workflow with defined filters and ranking behavior. |

## Existing-source exceptions

- **Sales OS** → keep with `cashh-radar`.
- **Founder Console** → keep with `fish-shooter-arcade`.
- **Four-Offer Launch** → keep in its current `founder-os` source path until a deliberate migration is executed and verified.
- **Spanish Fiesta** → a legacy repository was previously referenced under another GitHub account; recover/verify that source before creating a duplicate.
- **Resonance** → current continuity belongs in `AudioHardcore`.
- **Oops Academy** → keep as sibling content to `snarkyhowtos` until it has an independently maintained build/publishing pipeline.

## Creation standard

Each new repo should be seeded with `README.md`, `AI_HANDOFF.md`, `STATUS.md`, `NEXT_ACTIONS.md`, and `DECISIONS.md`. No secrets. Status must distinguish VERIFIED, IN PROGRESS, BLOCKED, and PLANNED.
