
    
    

select
    chargeback_ref as unique_field,
    count(*) as n_records

from dev_deel.dbt_vinicius.stg_globepay__chargeback_reports
where chargeback_ref is not null
group by chargeback_ref
having count(*) > 1


