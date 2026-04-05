-- ============================================================
-- IMPORT
-- ============================================================

with source as (
    select * from {{ source('raw', 'customers') }}
),

-- ============================================================
-- TRANSFORM
-- ============================================================

renamed as (
    select
        id                              as customer_id,
        first_name,
        last_name,
        email,
        created_at                      as customer_created_at,
        _updated_at
    from source
)

-- ============================================================
-- FINAL SELECT
-- ============================================================

select * from renamed
