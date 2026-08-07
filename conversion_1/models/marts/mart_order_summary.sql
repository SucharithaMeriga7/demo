{{
    config(
        materialized='table'
    )
}}

select
    CustId,
    OrderId,
    Name,
    EmailId,
    Region,
    ItemName,
    PricePerUnit,
    Qty,
    "Date",
    case when dbt_valid_to is null then true else false end as IsActive,
    dbt_valid_from,
    dbt_valid_to
from {{ ref('snp_order_summary') }}