select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

with all_values as (

    select
        chargeback as value_field,
        count(*) as n_records

    from dev_deel.dbt_vinicius.stg_globepay__chargeback_reports
    group by chargeback

)

select *
from all_values
where value_field not in (
    'True','False'
)



      
    ) dbt_internal_test