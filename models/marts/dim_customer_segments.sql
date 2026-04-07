{{
    config(
        materialized='view'
    )
}}

-- Purpose: Customer segmentation dimension derived from dim_customers.
-- Grain: One row per customer.

-- ------------------------
-- IMPORTS
-- ------------------------

with customers as (
    select * from {{ ref('dim_customers') }}
),

-- ------------------------
-- TRANSFORMATIONS
-- ------------------------

segmented as (
    select
        customer_id,
        first_name,
        last_name,
        email,
        lifetime_value,
        case
            when lifetime_value >= 1000 then 'high'
            when lifetime_value >= 300  then 'medium'
            else 'low'
        end as value_segment,
        case
            when number_of_orders >= 10 then 'loyal'
            when number_of_orders >= 3  then 'repeat'
            else 'one-time'
        end as order_segment
    from customers
),

-- ------------------------
-- FINAL
-- ------------------------

final as (
    select
        customer_id,
        first_name,
        last_name,
        email,
        lifetime_value,
        value_segment,
        order_segment
    from segmented
)

-- ------------------------
-- FINAL SELECT
-- ------------------------

select * from final
