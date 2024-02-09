{{
    config(
      materialized = 'incremental',
      unique_key = 'acceptance_ref',
      dist = 'acceptance_date_time',
      incremental_strategy = 'merge'
    )
}}


SELECT
    acceptance.acceptance_ref,
    acceptance.acceptance_status,
    acceptance.acceptance_source,
    acceptance.acceptance_internal_ref,
    acceptance.acceptance_date_time,
    acceptance.acceptance_state,
    acceptance.acceptance_cvv_provided,
    acceptance.acceptance_country,
    chargeback.chargeback_status,
    chargeback.chargeback_source,
    'USD' as currency,
    (acceptance.acceptance_amount * rates.currency_rate) as USD_amount,
    {{ bool_to_int('chargeback.chargeback_flag') }} as has_chargeback,
    CASE
        WHEN acceptance.acceptance_state = 'ACCEPTED' THEN 1
        WHEN acceptance.acceptance_state = 'DECLINED' THEN 0
        ELSE NULL 
    END as has_accepted

FROM {{ ref('stg_globepay__acceptance_reports') }} acceptance

LEFT JOIN {{ ref('stg_globepay__chargeback_reports') }} chargeback
ON acceptance.acceptance_ref = chargeback.chargeback_ref

LEFT JOIN {{ ref('int_payment__rates') }} rates
ON acceptance.acceptance_ref = rates.acceptance_ref
AND acceptance.acceptance_currency = rates.acceptance_currency
AND acceptance.acceptance_date_time = rates.acceptance_date_time

{% if is_incremental() %}
    WHERE acceptance.acceptance_date_time > (SELECT max(acceptance_date_time) FROM {{ this }})
{% endif %}
