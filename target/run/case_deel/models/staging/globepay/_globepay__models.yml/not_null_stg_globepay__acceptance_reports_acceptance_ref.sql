select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select acceptance_ref
from dev_deel.dbt_vinicius.stg_globepay__acceptance_reports
where acceptance_ref is null



      
    ) dbt_internal_test