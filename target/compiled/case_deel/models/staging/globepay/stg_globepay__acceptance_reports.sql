SELECT 
    external_ref        AS acceptance_ref,
    status              AS acceptance_status,
    source              AS acceptance_source,
    ref                 AS acceptance_internal_ref,
    date_time           AS acceptance_date_time,
    state               AS acceptance_state,
    cvv_provided        AS acceptance_cvv_provided,
    amount              AS acceptance_amount,
    country             AS acceptance_country,
    currency            AS acceptance_currency,
    rates               AS acceptance_rates
    
FROM raw_deel.globepay.acceptance_report