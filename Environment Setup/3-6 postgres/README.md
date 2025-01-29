1. Create Postgres Container
```
winpty docker run -it \
    --name my-postgres-container \
    --network pg-network \
    -e POSTGRES_USER="root" \
    -e POSTGRES_PASSWORD="root" \
    -e POSTGRES_DB="ny_taxi" \
    -v "C:\Users\N R RAVI\Desktop\Masters\DE_BootCamp\2_docker_sql\ny_taxi_postgres_data":/var/lib/postgresql/data \
    -p 5432:5432 \
    postgres:latest
```
2. Create pgadmin Container
```
winpty docker run -it \
    -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
    -e PGADMIN_DEFAULT_PASSWORD="root" \
    -p 8080:80 \
    --network=pg-network \
    --name pgadmin-2 \
    dpage/pgadmin4
```
3. Build ingest Code
```
docker build -t taxi_ingest:v001 .
```
4. Ingest Zones Data
```
winpty docker run -it \
    --network=pg-network \
    taxi_ingest:v001 \
        --user=root \
        --password=root \
        --host=my-postgres-container \
        --port=5432 \
        --db=ny_taxi \
        --tb=zones_hw \
        --url="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/misc/taxi_zone_lookup.csv"
```
5. Ingest Green Taxi Data
```
winpty docker run -it \
    --network=pg-network \
    taxi_ingest:v001 \
        --user=root \
        --password=root \
        --host=my-postgres-container \
        --port=5432 \
        --db=ny_taxi \
        --tb=green_taxi_hw \
        --url="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-10.csv.gz"
```

6. During the period of October 1st 2019 (inclusive) and November 1st 2019 (exclusive), how many trips, respectively, happened:

Up to 1 mile
```
SELECT COUNT(*) FROM green_taxi_hw
WHERE lpep_pickup_datetime>='2019-10-01' AND lpep_dropoff_datetime<'2019-11-01' AND Trip_distance<=1;
```
In between 1 (exclusive) and 3 miles (inclusive)
```
SELECT COUNT(*) FROM green_taxi_hw
WHERE lpep_pickup_datetime>='2019-10-01' AND lpep_dropoff_datetime<'2019-11-01' AND Trip_distance>1 AND Trip_distance<=3;
```
In between 3 (exclusive) and 7 miles (inclusive)
```
SELECT COUNT(*) FROM green_taxi_hw
WHERE lpep_pickup_datetime>='2019-10-01' AND lpep_dropoff_datetime<'2019-11-01' AND Trip_distance>3 AND Trip_distance<=7;
```
In between 7 (exclusive) and 10 miles (inclusive),
Over 10 miles
```
SELECT COUNT(*) FROM green_taxi_hw
WHERE lpep_pickup_datetime>='2019-10-01' AND lpep_dropoff_datetime<'2019-11-01' AND Trip_distance>10
```
7. Which was the pick up day with the longest trip distance? Use the pick up time for your calculations.
```
SELECT lpep_pickup_datetime FROM green_taxi_hw
WHERE Trip_distance = ( SELECT MAX(Trip_distance) from green_taxi_hw);
```
8. Which were the top pickup locations with over 13,000 in total_amount (across all trips) for 2019-10-18
```
SELECT z."Zone", SUM(Fare_amount) AS total_amount FROM green_taxi_hw gt
JOIN zones_hw z ON gt."PULocationID" = z."LocationID"
WHERE lpep_pickup_datetime>='2019-10-18' AND lpep_pickup_datetime<'2019-10-19'
GROUP BY z."Zone", gt."PULocationID"
ORDER BY total_amount desc;
```
9. For the passengers picked up in October 2019 in the zone named "East Harlem North" which was the drop off zone that had the largest tip
```
WITH a AS (
	SELECT z1."Zone" AS pickup, z2."Zone" AS dropoff, Tip_amount, lpep_pickup_datetime AS pd
	FROM green_taxi_hw gt
	JOIN zones_hw z1 on z1."LocationID"=gt."PULocationID"
	JOIN zones_hw z2 on z2."LocationID"=gt."DOLocationID"
)
SELECT dropoff, Tip_amount FROM a
WHERE pd>='2019-10-01' AND pd<'2019-11-01' AND pickup='East Harlem North'
ORDER BY Tip_amount DESC
