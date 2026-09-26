# Decisions

- "Customer paid" does not automatically mean supplier money is immediately available.
- SKU or another stable merchant-defined key should be preferred over stale provider object IDs where appropriate.
- No real production-store mutation without explicit authorization and a verified rollback path.
- Margin Calculator remains a module of the Fulfillment Checker unless explicitly split later.
- Store credentials and customer/order data never belong in Git history.
