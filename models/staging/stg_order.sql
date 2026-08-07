{{
    config(
        materialized='view',
        schema='staging'
    )
}}

with source as (

    select
        OrderId,
        CustId,
        ItemName,
        PricePerUnit,
        Qty,
        "Date"
    from {{ source('sdlc_wizard', 'orders') }}
    where CustId is not null
      and upper(trim(CustId)) <> 'NULL'
      and OrderId is not null
      and upper(trim(OrderId)) <> 'NULL'

),

deduplicated as (

    select
        OrderId,
        CustId,
        ItemName,
        PricePerUnit,
        Qty,
        "Date"
    from source
    qualify row_number() over (
        partition by OrderId
        order by "Date" nulls last
    ) = 1

)

select * from deduplicated
