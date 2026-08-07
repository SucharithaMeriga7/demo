select CustId
from {{ ref('mart_order_summary') }}
where CustId is null