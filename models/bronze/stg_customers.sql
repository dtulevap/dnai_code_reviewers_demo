{{
    config(
        materialized='table'
    )
}}

-- Purpose: Stage raw customers data from source. Rename columns for downstream use.
-- Grain: One row per customer.

-- ------------------------
-- IMPORTS
-- ------------------------

with source as (
    select * from {{ source('raw', 'customers') }}
),

-- ------------------------
-- TRANSFORMATIONS
-- ------------------------

staged as (
    select
        id                              as customer_id,
        first_name,
        last_name,
        email,
        created_at                      as customer_created_at,
        _updated_at
    from source
),

-- ------------------------
-- FINAL
-- ------------------------

final as (
    select * from staged
)

-- ------------------------
-- FINAL SELECT
-- ------------------------

select * from final
