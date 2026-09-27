# SmartPickShop Azure for Students — Infrastructure Rules

Updated: 2026-09-27 America/Los_Angeles

## Core stack

**ChatGPT → GitHub → Azure for Students → Azure Monitor / Application Insights → Database / Blob Storage → Evidence**

- ChatGPT designs, researches, troubleshoots, compares options, and writes code/configuration. It is not source control.
- GitHub is canonical for source code, tests, deployment definitions, handoffs, and rollback.
- Azure for Students is the execution layer only after cost and architecture-fit gates pass.
- Azure Monitor / Application Insights provide runtime evidence.
- Databases and Blob Storage hold durable state and files.

## Service guidance

- **Azure Functions:** preferred first reusable automation layer for webhooks, scheduled jobs, scoring, file processing, and background glue.
- **Blob Storage:** default home for files, PDFs, ZIPs, reports, screenshots, media, downloads, and backups.
- **Azure SQL / PostgreSQL / Cosmos DB:** choose by data model; do not pick by product-name novelty.
- **Container Apps:** strong for stateless/container-ready APIs and workers that can scale to zero.
- **App Service:** strong for conventional web apps and APIs. F1 is learning/testing and not automatically production-ready.
- **Azure AI / Foundry Tools:** use only when a measurable ROI/quality/customer-value test exists.
- **Azure DevOps:** additive only when it fills a real GitHub gap.
- **Virtual Machines:** last resort for OS-level control, legacy software, or a difficult temporary multi-service proof.

## Permanent rules

1. GitHub-first before Azure deployment.
2. Cost gate before billable creation: verify subscription, remaining credit, region, SKU/tier, expected cost, shutdown/scale-to-zero behavior, and delete path.
3. Free-first / consumption / scale-to-zero when the requirement is met.
4. Finish one highest-value Azure milestone before unrelated cloud work.
5. VM last resort.
6. Intermittent workloads should scale to zero when practical.
7. Database by fit and portability.
8. Blob-first for files/media.
9. AI requires measurable ROI or capability value.
10. Monitoring-before-launch.
11. Budgets/alerts before meaningful billable deployment; alerts warn but do not automatically stop spend.
12. Tag resources with Project, Owner, Environment, Purpose, CostClass, and ReviewDate/Expiration where possible.
13. Experiments get cleanup/review dates.
14. Secrets never belong in public GitHub.
15. Every deployment records resource IDs/names, region, tier, Git commit, endpoint, tests, cost state, monitoring proof, and rollback.
16. Do not run duplicate paid infrastructure without a deliberate migration/comparison/backup reason.
17. Migrate only for measurable cost, reliability, integration, student-credit leverage, or required capability.
18. Paid always-on upgrades require usage, reliability, or revenue evidence.
19. Durable state cannot live only on ephemeral disks.
20. Judge architecture by customer value and operating leverage, not complexity.
21. Preserve rollback before risky changes.
22. After two credible failed approaches, reassess rather than repeat.
23. Built ≠ deployed ≠ healthy ≠ verified ≠ launched ≠ sold ≠ paid.
24. Meaningful infrastructure changes get public-safe documentation.
25. Permanent external writes require explicit approval at the time of write.

## Azure for Students credit policy

Do not assume the original student credit remains. Verify the live balance first.

Once verified, use the remaining amount as a planning ceiling:
- 50% validated customer-facing / revenue-bearing workloads
- 20% reusable shared infrastructure and observability
- 15% controlled experiments
- 10% AI experiments with defined ROI/quality tests
- 5% emergency buffer

Allocation is not permission to spend; every resource still passes the cost gate.

## Highest-value next milestone

Before creating any new Azure resource:
1. identify the Azure for Students subscription;
2. verify remaining credit and expiration;
3. inventory existing resources, regions, tiers, and active cost;
4. record budget/alert state;
5. choose one small proof deployment only after the cost baseline exists.

Preferred first proof candidates: one reusable Azure Function, then a private Blob Storage vault, then one persistent database proof for a validated product.

## Truth boundary

This document defines the operating rules. It does not claim a verified current Azure credit balance, Azure resource inventory, deployment, customer payment, or revenue.
