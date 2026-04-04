-- ============================================================
-- IMPORT
-- ============================================================

with orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select * from {{ ref('stg_payments') }}
),

-- ============================================================
-- TRANSFORM
-- ============================================================

order_payments as (
    select
        order_id,
        sum(IFF(payment_method = 'credit_card',   payment_amount, 0)) as credit_card_amount,
        sum(IFF(payment_method = 'debit_card',    payment_amount, 0)) as debit_card_amount,
        sum(IFF(payment_method = 'bank_transfer', payment_amount, 0)) as bank_transfer_amount,
        sum(IFF(payment_method = 'gift_card',     payment_amount, 0)) as gift_card_amount,
        sum(IFF(payment_method = 'coupon',        payment_amount, 0)) as coupon_amount,
        sum(payment_amount)                                            as total_amount
    from payments
    group by order_id
),

final as (
    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.status,
        orders.order_amount,
        ZEROIFNULL(order_payments.credit_card_amount)   as credit_card_amount,
        ZEROIFNULL(order_payments.debit_card_amount)    as debit_card_amount,
        ZEROIFNULL(order_payments.bank_transfer_amount) as bank_transfer_amount,
        ZEROIFNULL(order_payments.gift_card_amount)     as gift_card_amount,
        ZEROIFNULL(order_payments.coupon_amount)        as coupon_amount,
        ZEROIFNULL(order_payments.total_amount)         as amount
    from orders
    left join order_payments using (order_id)
)

-- ============================================================
-- FINAL SELECT
-- ============================================================

select * from final
