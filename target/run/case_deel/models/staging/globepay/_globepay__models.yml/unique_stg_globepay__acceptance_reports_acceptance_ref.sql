select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    acceptance_ref as unique_field,
    count(*) as n_records

from dev_deel.dbt_vinicius.stg_globepay__acceptance_reports
where acceptance_ref is not null
group by acceptance_ref
having count(*) > 1



      
    ) dbt_internal_test