# AI Handoff

Updated: 2026-09-25

## Identity
- Project: $0-Upfront Fulfillment Checker
- Stable ID: P123
- Parent commerce system: P006
- Planned repository: `anastaysia94-sudo/fulfillment-checker`

## Current state
A Shopify/digital-fulfillment QA report and delivery artifacts are recoverable, but the actual checker source/package is not yet recovered in this sweep.

## Resume protocol
1. Recover the checker/app source before claiming implementation.
2. Verify formulas independently with representative order scenarios.
3. Keep "customer paid" separate from "funds available to pay supplier".
4. Test installation/integration in a safe Shopify development context.
5. Do not publish customer/store secrets or access tokens.
