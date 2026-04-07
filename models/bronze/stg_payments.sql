with source as (
    select * from {{ source('raw', 'payments') }}
),

renamed as (
    select
        id                              as payment_id,
        order_id,
        payment_method,
        amount                          as payment_amount,
        created_at                      as payment_created_at,
        _updated_at
    from source
)

select * from renamed
