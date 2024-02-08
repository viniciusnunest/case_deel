{{
    config(
      materialized = 'incremental',
      unique_key = 'acceptance_ref',
      dist = 'acceptance_date_time',
      incremental_strategy = 'delete+insert'
    )
}}

-- Here I opt to use jinja to ... 
{%- set currencies = ["USD", "CAD", "EUR", "GBP", "MXN", "SGD", "AUD"] -%}

{%- for currency in currencies %}
SELECT
    acceptance_ref,
    acceptance_date_time,
    '{{ currency }}' as acceptance_currency,
    GET(acceptance_rates, '{{ currency }}')::FLOAT as currency_rate
FROM {{ ref('stg_globepay__acceptance_reports') }}
WHERE acceptance_currency = '{{ currency }}'

{% if is_incremental() %}
    and acceptance_date_time >= (select max(acceptance_date_time) from {{ this }})
{% endif %}

{%- if not loop.last -%}
UNION ALL
{%- endif -%}
{%- endfor %}

