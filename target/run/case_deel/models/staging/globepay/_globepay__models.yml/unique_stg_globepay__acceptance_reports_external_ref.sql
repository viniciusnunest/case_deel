select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    external_ref as unique_field,
    count(*) as n_records

from dev_deel.dbt_vinicius.stg_globepay__acceptance_reports
where external_ref is not null
group by external_ref
having count(*) > 1



      
    ) dbt_internal_test