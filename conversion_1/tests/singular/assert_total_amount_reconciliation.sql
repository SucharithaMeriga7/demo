with order_total as (
    select sum(PricePerUnit * Qty) as total
    from {{ ref('mart_order_summary') }}
    where IsActive = true
),
aggregate_total as (
    select sum(TotalAmount) as total
    from {{ ref('mart_customer_aggregate_spend') }}
)
select
    o.total as order_total,
    a.total as aggregate_total
from order_total o
cross join aggregate_total a
where coalesce(o.total, 0) <> coalesce(a.total, 0)