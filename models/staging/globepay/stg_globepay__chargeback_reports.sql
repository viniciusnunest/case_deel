SELECT 
    external_ref        AS chargeback_ref,
    status              AS chargeback_status,
    source              AS chargeback_source,
    chargeback          AS chargeback_flag
    
FROM {{ source('globepay', 'chargeback_report')}}
