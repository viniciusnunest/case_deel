WITH source AS (
    SELECT 
        external_ref,
        status,
        source,
        ref,
        date_time,
        state,
        cvv_provided,
        amount,
        country,
        currency,
        rates
    FROM {{ source('globepay', 'acceptance_report') }}
)

SELECT
    external_ref,
    status,
    source,
    ref,
    date_time,
    state,
    cvv_provided,
    amount,
    country,
    currency,
    rates
FROM source
