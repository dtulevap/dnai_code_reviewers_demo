{{
    config(
        materialized='table'
    )
}}

-- Purpose: Stage raw payments data from source. Rename columns for downstream use.
-- Grain: One row per payment.

-- ------------------------
-- IMPORTS
-- ------------------------

with source as (
    select * from {{ source('raw', 'payments') }}
),

-- ------------------------
-- TRANSFORMATIONS
-- ------------------------

staged as (
    select
        id                              as payment_id,
        order_id,
        payment_method,
        amount                          as payment_amount,
        created_at                      as payment_created_at,
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
