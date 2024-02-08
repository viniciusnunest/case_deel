WITH source AS (
    SELECT 
        external_ref,
        status,
        source,
        chargeback
    FROM {{ source('globepay', 'chargeback_report') }}
)

SELECT
    external_ref,
    status,
    source,
    chargeback
FROM source
