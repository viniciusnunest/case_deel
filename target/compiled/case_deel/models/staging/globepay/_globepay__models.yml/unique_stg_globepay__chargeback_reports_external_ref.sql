
    
    

select
    external_ref as unique_field,
    count(*) as n_records

from dev_deel.dbt_vinicius.stg_globepay__chargeback_reports
where external_ref is not null
group by external_ref
having count(*) > 1


