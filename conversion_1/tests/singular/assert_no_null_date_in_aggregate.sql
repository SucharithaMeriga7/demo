select "Date"
from {{ ref('mart_customer_aggregate_spend') }}
where "Date" is null