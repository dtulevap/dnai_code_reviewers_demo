-- Monthly revenue summary
select
    date_trunc('month', order_date)    as order_month,
    count(order_id)                    as number_of_orders,
    sum(amount)                        as total_revenue,
    avg(amount)                        as avg_order_value,
    count(distinct customer_id)        as unique_customers
from {{ ref('fct_orders') }}
where status = 'completed'
group by 1
order by 1
