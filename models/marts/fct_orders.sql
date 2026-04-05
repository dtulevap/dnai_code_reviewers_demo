with orders as (
    select * from {{ ref('int_orders_with_payments') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

final as (
    select
        orders.order_id,
        orders.customer_id,
        customers.first_name,
        customers.last_name,
        customers.email,
        orders.order_date,
        datediff('day', orders.order_date, current_date()) as days_since_order,
        orders.status,
        orders.order_amount,
        orders.credit_card_amount,
        orders.debit_card_amount,
        orders.bank_transfer_amount,
        orders.gift_card_amount,
        orders.coupon_amount,
        orders.amount
    from orders
    left join customers using (customer_id)
)

select * from final
