-- TotalAmount reconciliation vs mart_order_summary
with expected as (
    select Name, "Date", sum(PricePerUnit * Qty) as expected_total
    from {{ ref('mart_order_summary') }}
    where IsActive = true and Name is not null and "Date" is not null
    group by Name, "Date"
),
actual as (
    select Name, "Date", TotalAmount
    from {{ ref('mart_customer_aggregate_spend') }}
),
mismatches as (
    select
        coalesce(e.Name, a.Name) as Name,
        coalesce(e."Date", a."Date") as "Date",
        e.expected_total,
        a.TotalAmount
    from expected e
    full outer join actual a
        on e.Name = a.Name and e."Date" = a."Date"
    where coalesce(e.expected_total, -1) <> coalesce(a.TotalAmount, -1)
)
select * from mismatches
