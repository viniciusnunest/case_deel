{{
    config(
      dist = 'acceptance_date_time',
      tags = ['daily']
    )
}}

SELECT
    reports.acceptance_country,
    reports.acceptance_date_time,
    reports.acceptance_cvv_provided,
    reports.chargeback_status,
    reports.has_chargeback,
    reports.has_accepted,
    SUM(reports.USD_amount) as sum_amount,
    SUM(reports.has_accepted) as sum_accepted,
    SUM(reports.has_chargeback) as sum_chargeback

FROM {{ ref('int_payment__reports') }} as reports

{{ dbt_utils.group_by(n=6) }}