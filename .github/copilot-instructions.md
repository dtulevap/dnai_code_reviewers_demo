# Copilot Instructions

This is a dbt project targeting Snowflake. Apply the following rules to all code suggestions.

## 1. Use Snowflake SQL and dbt Jinja syntax
Write SQL that is valid for Snowflake (e.g. `QUALIFY`, `IFF`, `ZEROIFNULL`, `TO_TIMESTAMP_NTZ`). Use dbt Jinja constructs (`{{ config() }}`, `{{ var() }}`, `{{ env_var() }}`, macros) where appropriate.

## 2. No hardcoded object references
Never reference raw database/schema/table names directly. Always use:
- `{{ source('source_name', 'table_name') }}` for raw source tables
- `{{ ref('model_name') }}` for dbt models

## 3. Model comment formatting
Every model must have three clearly separated sections marked with comment lines:

```sql
-- ============================================================
-- IMPORT
-- ============================================================

-- ============================================================
-- TRANSFORM
-- ============================================================

-- ============================================================
-- FINAL SELECT
-- ============================================================
```

## 4. Keep SQL and YAML in sync
Every column in the model's `.yml` file must exist in the SQL `SELECT`, and every column in the final `SELECT` must be documented in the `.yml`. No missing fields in either direction.
