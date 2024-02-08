select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select external_ref
from dev_deel.dbt_vinicius.stg_globepay__chargeback_reports
where external_ref is null



      
    ) dbt_internal_test