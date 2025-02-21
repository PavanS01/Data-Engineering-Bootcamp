select * 
from {{ source('raw_nyc_tripdata', 'green_tripdata' ) }}