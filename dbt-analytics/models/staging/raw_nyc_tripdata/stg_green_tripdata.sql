with 

source as (

    select *,
        concat(cast(data_file_year as string), '-', 
            case
                when data_file_month>=1 and data_file_month<=3 then 'Q1'
                when data_file_month>=4 and data_file_month<=6 then 'Q2'
                when data_file_month>=7 and data_file_month<=9 then 'Q3'
                when data_file_month>=10 and data_file_month<=12 then 'Q4'
            end) as year_quarter,
        case
            when data_file_month>=1 and data_file_month<=3 then 'Q1'
            when data_file_month>=4 and data_file_month<=6 then 'Q2'
            when data_file_month>=7 and data_file_month<=9 then 'Q3'
            when data_file_month>=10 and data_file_month<=12 then 'Q4'
        end as quarter,
        'green' as taxi_type
    from {{ source('raw_nyc_tripdata', 'green_tripdata') }}

),

quarterly_grouped as (

    select
        sum(fare_amount) as total_quarter_fare,
        quarter,
        data_file_year,
        year_quarter,
        taxi_type
    from source
    group by quarter, data_file_year, year_quarter, taxi_type
)

select * from quarterly_grouped
