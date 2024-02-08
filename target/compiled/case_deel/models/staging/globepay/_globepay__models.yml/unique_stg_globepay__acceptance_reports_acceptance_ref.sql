
    
    

select
    acceptance_ref as unique_field,
    count(*) as n_records

from dev_deel.dbt_vinicius.stg_globepay__acceptance_reports
where acceptance_ref is not null
group by acceptance_ref
having count(*) > 1


