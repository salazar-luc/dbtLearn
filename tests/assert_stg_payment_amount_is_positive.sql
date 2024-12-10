select
    s_p.order_id
    ,sum(s_p.payment_amount) as total_amount
from
    {{ ref('stg_payment') }} as s_p
group by
    s_p.order_id
having
    total_amount < 0