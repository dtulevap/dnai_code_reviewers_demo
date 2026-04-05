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
        sum(case when payment_method = 'credit_card'   then payment_amount else 0 end) as credit_card_amount,
        sum(case when payment_method = 'debit_card'    then payment_amount else 0 end) as debit_card_amount,
        sum(case when payment_method = 'bank_transfer' then payment_amount else 0 end) as bank_transfer_amount,
        sum(case when payment_method = 'gift_card'     then payment_amount else 0 end) as gift_card_amount,
        sum(case when payment_method = 'coupon'        then payment_amount else 0 end) as coupon_amount,
        sum(payment_amount)                                                             as total_amount
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
        zeroifnull(order_payments.credit_card_amount)   as credit_card_amount,
        zeroifnull(order_payments.debit_card_amount)    as debit_card_amount,
        zeroifnull(order_payments.bank_transfer_amount) as bank_transfer_amount,
        zeroifnull(order_payments.gift_card_amount)     as gift_card_amount,
        zeroifnull(order_payments.coupon_amount)        as coupon_amount,
        zeroifnull(order_payments.total_amount)         as amount
    from orders
    left join order_payments using (order_id)
)

-- ============================================================
-- FINAL SELECT
-- ============================================================

select * from final
