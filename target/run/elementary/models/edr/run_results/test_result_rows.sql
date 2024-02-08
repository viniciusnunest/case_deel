
  
    

        create or replace transient table dev_deel.dbt_vinicius.test_result_rows
         as
        (

-- depends_on: dev_deel.dbt_vinicius.elementary_test_results
select * from (
            select
            
                
        cast('this_is_just_a_long_dummy_string' as varchar) as elementary_test_results_id

,
                
        cast('this_is_just_a_long_dummy_string' as varchar) as result_row

,
                cast('2091-02-17' as timestamp) as detected_at

,
                cast('2091-02-17' as timestamp) as created_at


        ) as empty_table
        where 1 = 0
        );
      
  