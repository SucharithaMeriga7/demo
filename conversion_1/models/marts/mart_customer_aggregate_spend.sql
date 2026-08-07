{{
    config(
        materialized='table'
    )
}}

select
    Name,
    "Date",
    sum(PricePerUnit * Qty) as TotalAmount
from {{ ref('mart_order_summary') }}
where IsActive = true
group by Name, "Date"