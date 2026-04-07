{{
    config(
        materialized='view'
    )
}}

-- Purpose: Customer dimension table with aggregated order statistics and lifetime value.
-- Grain: One row per customer.

-- ------------------------
-- IMPORTS
-- ------------------------

with customers as (
    select * from {{ ref('int_customers') }}
),

-- ------------------------
-- TRANSFORMATIONS
-- ------------------------

enriched as (
    select
        customer_id,
        first_name,
        last_name,
        email,
        customer_created_at,
        first_order_date,
        most_recent_order_date,
        number_of_orders,
        lifetime_value
    from customers
),

-- ------------------------
-- FINAL
-- ------------------------

final as (
    select * from enriched
)

-- ------------------------
-- FINAL SELECT
-- ------------------------

select * from final
