# dbt Copilot CLI Summary

## Core Requirements

**Platform:** dbt + Snowflake (lowercase SQL syntax)

**Architecture:** Medallion (Bronze → Silver → Gold)

**Naming:** `<layer>_<object_type>_<domain>_<object_description>_<action>.sql`
- Layers: `bronze`, `silver`, `gold`  
- Object types: `_fct_`, `_dim_`, `_hlp_`, `_mart_`, `_agg_`
- Domains: `_shf_`, `_prg_`, `_mkl_`, `_adp_`, `_dx_`, `_inf_`, `_mdm_`

**Materialization:**
- Bronze/Silver: `table`
- Gold: `view`

**Required Structure (4-step CTE):**
1. IMPORTS (sources/refs with `select *`)
2. TRANSFORMATIONS (business logic CTEs)
3. FINAL CTE (named `final`)
4. FINAL SELECT (`select * from final`)

**CTE Separators:** Use `------------------------` comment blocks between each step

**Documentation:**
- Model header comment with Purpose/Grain
- Schema.yml for every model
- ALL fields in SQL must exist in YAML (and vice versa)

**Layer Rules:**

*No hardcoded Snowflake objects - always use `source()` or `ref()`*

- Bronze: `source()` only, minimal transforms
- Silver: `ref()` to bronze and other silver models, transformations and business logic
- Gold: `ref()` to silver models only, aggregations only, final layer consumed in Power BI or exposed to business users in Snowflake

**Quality:** Production-ready, consistent, maintainable, follows DRY principle
