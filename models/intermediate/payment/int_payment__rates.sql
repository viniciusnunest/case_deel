{{
    config(
      materialized = 'incremental',
      unique_key = 'acceptance_ref',
      dist = 'acceptance_date_time',
      incremental_strategy = 'merge'
    )
}}

-- Here I opt to use jinja to ... 
{%- set currencies = ["USD", "CAD", "EUR", "GBP", "MXN", "SGD", "AUD"] -%}

{%- for currency in currencies %}
SELECT
    acceptance_ref,
    acceptance_date_time,
    '{{ currency }}' as acceptance_currency,
    ROUND(GET(acceptance_rates, '{{ currency }}')::FLOAT,2) as currency_rate
FROM {{ ref('stg_globepay__acceptance_reports') }}
WHERE acceptance_currency = '{{ currency }}'

{% if is_incremental() %}
    AND acceptance_date_time > (SELECT max(acceptance_date_time) FROM {{ this }})
{% endif %}

{%- if not loop.last -%}
UNION ALL
{%- endif -%}
{%- endfor %}

