{{
    config(
        materialized='table'
    )
}}

select * from {{ ref('stg_green_tripdata') }}
union all
select * from {{ ref('stg_yellow_tripdata') }}