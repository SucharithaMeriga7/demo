{{
    config(
        materialized='view'
    )
}}

select
    c.CustId,
    o.OrderId,
    c.Name,
    c.EmailId,
    c.Region,
    o.ItemName,
    o.PricePerUnit,
    o.Qty,
    o."Date"
from {{ ref('stg_customer') }} c
inner join {{ ref('stg_order') }} o
    on c.CustId = o.CustId