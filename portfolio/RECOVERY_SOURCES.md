# RECOVERY SOURCES

Updated: 2026-09-25

Purpose: record non-GitHub artifacts that can help reconstruct or migrate projects without exposing private Google Drive IDs or credentials.

## Verified Google Drive recovery leads

| Target project | Recovery evidence located | Recovery state |
|---|---|---|
| P009 Project Continuity | `Master Project Ledger — SmartPickShop — CURRENT — 2026-09-25` plus Markdown and DOCX mirrors | VERIFIED location |
| P007 Corporate Hieroglyphics / LNC | `Corporate Hieroglyphics — SmartPickShop — CURRENT` and master-ledger references | VERIFIED location |
| P018 Promotion Engine | `PROMOTION_ENGINE_2026-09-12_FINAL.xlsx` plus prospect-sales-engine spreadsheets | VERIFIED location |
| P022 Remote Career Command Center | `03_REMOTE_CAREER_COMMAND_CENTER_Tracker_V2.xlsx`, Master Manual V2 PDF/DOCX | VERIFIED location |
| P025 WASTEBounty | `WASTEBounty Pilot Operations` Drive folder | VERIFIED location |
| P035 PTEDBoss / PartyTeller | Master-ledger records located; no distinct source package confirmed in Drive search | PARTIAL |
| P049 SugarRush Slasher | Master-ledger records located; no distinct source package confirmed in Drive search | PARTIAL |
| P123 Fulfillment Checker | Corporate Hieroglyphics + master-ledger references located; distinct source package not confirmed | PARTIAL |
| P125 AI Nexus | Master-ledger records located; distinct source package not confirmed | PARTIAL |
| P140 MICRO-SNIPE | archived GROK register delta contains project evidence | PARTIAL |
| Santa Clara County Prospecting PWA | `Santa Clara County Prospecting PWA.txt` plus a related spreadsheet result | PARTIAL |

## Important finding: Santa Clara County Prospecting PWA

The recovered TXT file is a rendered/text snapshot of the 450-lead app UI, not application source code. It confirms app state and lead content but cannot reconstruct the full PWA by itself.

## Recovery rule

A filename or chat claim proves that an artifact existed; it does not prove that current runnable source has been recovered. Before migrating a project into a new repository, classify the recovered material as one of:

- SOURCE: runnable/editable implementation source.
- BUILD: generated APK/ZIP/static bundle or other compiled/exported output.
- DATA: spreadsheets, lead datasets, registers, configuration data.
- DESIGN: screenshots, graphics, mockups, copy.
- HISTORY: chat transcript, ledger entry, status report, or handoff.
- UNKNOWN: artifact not yet inspected.

Only SOURCE plus a successful build/test should be treated as implementation recovery.
