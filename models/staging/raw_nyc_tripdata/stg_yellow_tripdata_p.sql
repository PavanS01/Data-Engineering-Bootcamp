with 

sources as (

    select *, 'yellow' as taxi_type from {{ source('raw_nyc_tripdata', 'yellow_tripdata') }}
    where fare_amount > 0 and trip_distance > 0 and payment_type in ('1', '2')
),

grouped as (

    select
        fare_amount,
        taxi_type, 
        data_file_month,
        data_file_year
    from sources

)

select * from grouped