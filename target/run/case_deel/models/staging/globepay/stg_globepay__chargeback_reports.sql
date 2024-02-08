
  create or replace   view dev_deel.dbt_vinicius.stg_globepay__chargeback_reports
  
   as (
    WITH source AS (
    SELECT 
        external_ref,
        status,
        source,
        chargeback
    FROM raw_deel.globepay.chargeback_report
)

SELECT
    external_ref,
    status,
    source,
    chargeback
FROM source
  );

