{{
    config(
        materialized='table'
    )
}}

-- Purpose: Stage raw orders data from source. Rename columns for downstream use.
-- Grain: One row per order.

-- ------------------------
-- IMPORTS
-- ------------------------

with source as (
    select * from {{ source('raw', 'orders') }}
),

-- ------------------------
-- TRANSFORMATIONS
-- ------------------------

staged as (
    select
        id                              as order_id,
        user_id                         as customer_id,
        order_date,
        status,
        amount                          as order_amount,
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
