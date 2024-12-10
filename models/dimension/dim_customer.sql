with cte_customer_orders as (
    select
        stg_o.customer_id
        ,min(stg_o.order_date) as first_order_date
        ,max(stg_o.order_date) as most_recent_order_date
        ,count(stg_o.order_id) as number_of_orders
    from
        {{ ref("stg_order") }} as stg_o
    group by
        stg_o.customer_id
)
,cte_lifetime_value as (
    select
        fct_o.customer_id
        ,sum(fct_o.payment_amount) as lifetime_value
    from
        {{ ref("fct_order") }} as fct_o
    group by
        fct_o.customer_id
)

select
    stg_c.customer_id
    ,stg_c.first_name
    ,stg_c.last_name
    ,cte_co.first_order_date
    ,cte_co.most_recent_order_date
    ,coalesce(cte_co.number_of_orders, 0) as number_of_orders
    ,coalesce(cte_lv.lifetime_value) as lifetime_value
from
    {{ ref("stg_customer") }} as stg_c
    left join cte_customer_orders as cte_co on cte_co.customer_id = stg_c.customer_id
    left join cte_lifetime_value as cte_lv on  cte_lv.customer_id = stg_c.customer_id