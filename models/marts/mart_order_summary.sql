{{
    config(
        materialized='table',
        schema='marts'
    )
}}

with snapshot_data as (

    select
        CustId,
        Name,
        EmailId,
        Region,
        OrderId,
        ItemName,
        PricePerUnit,
        Qty,
        "Date",
        dbt_valid_from as StartDate,
        dbt_valid_to as EndDate,
        case when dbt_valid_to is null then true else false end as IsActive
    from {{ ref('snp_order_summary') }}

)

select * from snapshot_data
