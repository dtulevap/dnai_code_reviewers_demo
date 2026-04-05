with source as (
    select * from {{ source('raw', 'orders') }}
),

renamed as (
    select
        id                              as order_id,
        user_id                         as customer_id,
        order_date,
        status,
        amount                          as order_amount,
        case when status = 'returned' then true else false end as is_returned,
        _updated_at
    from source
)

select * from renamed
