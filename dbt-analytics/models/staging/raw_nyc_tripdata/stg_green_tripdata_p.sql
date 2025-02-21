with 

sources as (

    select *, 'green' as taxi_type from {{ source('raw_nyc_tripdata', 'green_tripdata') }}
    where fare_amount > 0 and trip_distance > 0 and payment_type in ('1.0', '2.0')
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
