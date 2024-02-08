select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select chargeback
from dev_deel.dbt_vinicius.stg_globepay__chargeback_reports
where chargeback is null



      
    ) dbt_internal_test