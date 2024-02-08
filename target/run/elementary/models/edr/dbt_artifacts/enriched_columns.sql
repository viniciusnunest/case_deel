
  create or replace   view dev_deel.dbt_vinicius.enriched_columns
  
   as (
    


with information_schema_columns as (
    select
        lower(database_name) as database_name,
        lower(schema_name) as schema_name,
        lower(table_name) as table_name,
        lower(column_name) as name,
        data_type
    from dev_deel.dbt_vinicius.information_schema_columns
),

dbt_columns as (
    select
        lower(database_name) as database_name,
        lower(schema_name) as schema_name,
        lower(table_name) as table_name,
        lower(name) as name,
        description
    from dev_deel.dbt_vinicius.dbt_columns
)

select
    database_name,
    schema_name,
    table_name,
    name,
    data_type,
    description
from information_schema_columns
left join dbt_columns using (database_name, schema_name, table_name, name)
  );

