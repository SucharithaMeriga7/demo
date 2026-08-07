-- No NULL CustId in stg_order
select CustId
from {{ ref('stg_order') }}
where CustId is null
