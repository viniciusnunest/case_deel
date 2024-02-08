{{
    config(
      materialized = 'incremental',
      unique_key = 'acceptance_ref',
      dist = 'acceptance_date_time',
      incremental_strategy = 'merge'
    )
}}


SELECT
    a.acceptance_ref,
    a.acceptance_status,
    a.acceptance_source,
    a.acceptance_internal_ref,
    a.acceptance_date_time,
    a.acceptance_state,
    a.acceptance_cvv_provided,
    a.acceptance_amount,
    a.acceptance_country,
    a.acceptance_currency,
    a.acceptance_rates,
    b.chargeback_status,
    b.chargeback_source,
    b.chargeback_flag
FROM {{ ref('stg_globepay__acceptance_reports') }} a
LEFT JOIN {{ ref('stg_globepay__chargeback_reports') }} b
ON a.acceptance_ref = b.chargeback_ref

{% if is_incremental() %}
    and acceptance_date_time >= (select max(acceptance_date_time) from {{ this }})
{% endif %}