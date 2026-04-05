with source as (
    select * from {{ source('raw', 'orders') }}
),

renamed as (
    select
        id                              as order_id,
        user_id                         as customer_id,
        order_date,
        status,
        case when status = 'returned' then true else false end as is_returned,
        amount                          as order_amount,
        _updated_at
    from source
)

select * from renamed
