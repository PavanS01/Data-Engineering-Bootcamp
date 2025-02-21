{{
    config(
        materialized='table'
    )
}}

select * from {{ ref('stg_green_tripdata_p') }}
union all
select * from {{ ref('stg_yellow_tripdata_p') }}