{{
    config(
        materialized='table'
    )
}}

select dispatching_base_num,
        pickup_datetime,
        dropoff_datetime,
        pulocationid,
        dolocationid,
        sr_flag,
        affiliated_base_number,
        TIMESTAMP_DIFF(PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', dropoff_datetime),
        PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', pickup_datetime), SECOND) AS duration_seconds,
        year,
        month,
        z1.zone as pu_zone,
        z2.zone as do_zone
from {{ ref('stg_fhv_2019_hw4') }} fhv
left join {{ ref('stg_zones') }} z1 on fhv.pulocationid = z1.locationid
left join {{ ref('stg_zones') }} z2 on fhv.dolocationid = z2.locationid