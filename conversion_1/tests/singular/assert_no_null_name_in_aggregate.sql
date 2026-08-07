select Name
from {{ ref('mart_customer_aggregate_spend') }}
where Name is null