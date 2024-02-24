-- Use the `ref` function to SELECT FROM other models
select * from {{ ref("my_first_dbt_model") }} where id = 1
