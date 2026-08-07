{% snapshot snp_order_summary %}

{{
    config(
        target_schema='snapshots',
        unique_key="concat(CustId, '|', OrderId)",
        strategy='check',
        check_cols=['Name', 'EmailId', 'Region', 'ItemName', 'PricePerUnit', 'Qty', '"Date"'],
        invalidate_hard_deletes=True
    )
}}

select * from {{ ref('int_order_summary_source') }}

{% endsnapshot %}
