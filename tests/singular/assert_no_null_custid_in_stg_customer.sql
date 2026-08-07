-- No NULL CustId in stg_customer
select CustId
from {{ ref('stg_customer') }}
where CustId is null
