select
    js_o.id as order_id
    ,js_o.user_id as customer_id
    ,js_o.order_date
    ,js_o.status as order_status
from
    {{ source('jaffle_shop', 'orders') }} as js_o