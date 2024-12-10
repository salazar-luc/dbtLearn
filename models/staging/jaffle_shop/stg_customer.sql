select
    js_o.id as customer_id
    ,js_o.first_name as customer_first_name
    ,js_o.last_name as customer_last_name
from
    {{ source('jaffle_shop', 'customers') }} as js_o