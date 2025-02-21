with 

source as (

    select *,
        PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', pickup_datetime) AS parsed_timestamp
    from {{ source('raw_nyc_tripdata', 'fhv_2019_hw4') }}

),

renamed as (

    select
        dispatching_base_num,
        pickup_datetime,
        dropoff_datetime,
        pulocationid,
        dolocationid,
        sr_flag,
        affiliated_base_number,
        EXTRACT(YEAR FROM parsed_timestamp) AS year,
        EXTRACT(MONTH FROM parsed_timestamp) AS month

    from source

)

select * from renamed
