-- No NULL Name or Date in mart_customer_aggregate_spend
select *
from {{ ref('mart_customer_aggregate_spend') }}
where Name is null
   or "Date" is null
