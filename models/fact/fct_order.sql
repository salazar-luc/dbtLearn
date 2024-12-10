with cte_order_valid_payment as (
    select
        stg_p.order_id
        ,sum(case when stg_p.payment_status = 'success' then stg_p.payment_amount end) as valid_amount
    from
        {{ ref("stg_payment") }} as stg_p
    group by
        stg_p.order_id
)

select
    stg_c.customer_id
    ,stg_o.order_id
    ,stg_p.payment_date
    ,coalesce(cte_ovp.valid_amount, 0) as payment_amount
from
    {{ ref("stg_customer") }} as stg_c
    join {{ ref("stg_order") }} as stg_o on stg_o.customer_id = stg_c.customer_id
    join {{ ref("stg_payment") }} as stg_p on stg_p.order_id = stg_o.order_id
    left join cte_order_valid_payment as cte_ovp on cte_ovp.order_id = stg_p.order_id