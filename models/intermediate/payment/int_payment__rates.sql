{{
    config(
      materialized = 'incremental',
      unique_key = 'acceptance_ref',
      dist = 'acceptance_date_time',
      incremental_strategy = 'merge'
    )
}}

-- I chose to use jinja because it would be simpler to read this query, 
-- instead of having several union alls exposed here. In addition, it also 
-- facilitates maintenance if you have any new currency. 

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

