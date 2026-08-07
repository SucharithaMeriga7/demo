{{
    config(
        materialized='view',
        schema='intermediate'
    )
}}

with customer as (

    select * from {{ ref('stg_customer') }}

),

orders as (

    select * from {{ ref('stg_order') }}

),

joined as (

    select
        c.CustId,
        c.Name,
        c.EmailId,
        c.Region,
        o.OrderId,
        o.ItemName,
        o.PricePerUnit,
        o.Qty,
        o."Date"
    from customer c
    inner join orders o
        on c.CustId = o.CustId

)

select * from joined
