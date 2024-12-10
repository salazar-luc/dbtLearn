select
    s_p.orderid as order_id
    ,s_p.id as payment_id
    ,s_p.created as payment_date
    ,s_p.status as payment_status
    ,s_p.paymentmethod as payment_method
    ,(s_p.amount / 100) as payment_amount
from
    `dbt-tutorial`.stripe.payment as s_p