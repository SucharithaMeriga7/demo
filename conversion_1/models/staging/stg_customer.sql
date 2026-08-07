{{
    config(
        materialized='view'
    )
}}

select
    CustId,
    Name,
    EmailId,
    Region
from {{ source('sdlc_wizard', 'customer') }}
where CustId is not null
  and upper(trim(CustId)) <> 'NULL'
  and Name is not null
  and upper(trim(Name)) <> 'NULL'
qualify row_number() over (partition by CustId order by Name nulls last) = 1