-- ============================================================
-- IMPORT
-- ============================================================

with source as (
    select * from {{ source('raw', 'orders') }}
),

-- ============================================================
-- TRANSFORM
-- ============================================================

renamed as (
    select
        id                              as order_id,
        user_id                         as customer_id,
        order_date,
        status,
        amount                          as order_amount,
        _updated_at
    from source
)

-- ============================================================
-- FINAL SELECT
-- ============================================================

select * from renamed
