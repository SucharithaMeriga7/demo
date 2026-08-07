{{
    config(
        materialized='view'
    )
}}

select
    OrderId,
    ItemName,
    PricePerUnit,
    Qty,
    "Date",
    CustId
from {{ source('sdlc_wizard', 'orders') }}
where CustId is not null
  and upper(trim(CustId)) <> 'NULL'
  and OrderId is not null
  and upper(trim(OrderId)) <> 'NULL'
qualify row_number() over (partition by OrderId order by "Date" nulls last) = 1