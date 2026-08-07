{{
    config(
        materialized='table',
        schema='marts'
    )
}}

with active_orders as (

    select
        Name,
        PricePerUnit,
        Qty,
        "Date"
    from {{ ref('mart_order_summary') }}
    where IsActive = true
      and Name is not null
      and "Date" is not null

),

aggregated as (

    select
        Name,
        sum(PricePerUnit * Qty) as TotalAmount,
        "Date"
    from active_orders
    group by Name, "Date"

)

select * from aggregated
