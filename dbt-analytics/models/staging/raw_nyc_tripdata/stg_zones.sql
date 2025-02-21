with 

source as (

    select * from {{ source('raw_nyc_tripdata', 'zones') }}

),

renamed as (

    select
        locationid,
        borough,
        zone,
        service_zone

    from source

)

select * from renamed
