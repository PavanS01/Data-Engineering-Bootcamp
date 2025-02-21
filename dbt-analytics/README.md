Taxi Quarterly Revenue Growth

Yellow
```
with yoy_calc as (
  select round((y2.total_quarter_fare - y1.total_quarter_fare) / (y1.total_quarter_fare),3) as yoy, y2.year_quarter, y2.taxi_type
  from agile-athlete-449216-m2.dbt_hw_4.fct_taxi_trips_quarterly_revenue as y2
  join agile-athlete-449216-m2.dbt_hw_4.fct_taxi_trips_quarterly_revenue as y1 on y2.data_file_year = (y1.data_file_year + 1) and y1.quarter=y2.quarter and y1.taxi_type=y2.taxi_type
)
select * from yoy_calc
where taxi_type = 'yellow'
order by yoy 
```

Green
```
with yoy_calc as (
  select round((y2.total_quarter_fare - y1.total_quarter_fare) / (y1.total_quarter_fare),3) as yoy, y2.year_quarter, y2.taxi_type
  from agile-athlete-449216-m2.dbt_hw_4.fct_taxi_trips_quarterly_revenue as y2
  join agile-athlete-449216-m2.dbt_hw_4.fct_taxi_trips_quarterly_revenue as y1 on y2.data_file_year = (y1.data_file_year + 1) and y1.quarter=y2.quarter and y1.taxi_type=y2.taxi_type
)
select * from yoy_calc
where taxi_type = 'green'
order by yoy 
```

P97/P95/P90 Taxi Monthly Fare

P97
```
with a as (
  select fare_amount, taxi_type from `agile-athlete-449216-m2.dbt_hw_4.fct_taxi_trips_monthly_fare_p95`
  where data_file_month=4 and data_file_year=2020
),
b as(
  SELECT 
    PERCENTILE_CONT(fare_amount, 0.97) OVER(partition by taxi_type) as median, taxi_type
  FROM a
)
select avg(median) as ptile, taxi_type
from b
group by taxi_type
```

P95
```
with a as (
  select fare_amount, taxi_type from `agile-athlete-449216-m2.dbt_hw_4.fct_taxi_trips_monthly_fare_p95`
  where data_file_month=4 and data_file_year=2020
),
b as(
  SELECT 
    PERCENTILE_CONT(fare_amount, 0.95) OVER(partition by taxi_type) as median, taxi_type
  FROM a
)
select avg(median) as ptile, taxi_type
from b
group by taxi_type
```

P90
```
with a as (
  select fare_amount, taxi_type from `agile-athlete-449216-m2.dbt_hw_4.fct_taxi_trips_monthly_fare_p95`
  where data_file_month=4 and data_file_year=2020
),
b as(
  SELECT 
    PERCENTILE_CONT(fare_amount, 0.90) OVER(partition by taxi_type) as median, taxi_type
  FROM a
)
select avg(median) as ptile, taxi_type
from b
group by taxi_type
```

Top #Nth longest P90 travel time Location for FHV

Newark Airport
```
with a as (
  select do_zone, duration_seconds, pu_zone, year, month from `agile-athlete-449216-m2.dbt_hw_4.fct_fhv_monthly_zone_traveltime_p90`
),
b as (
  SELECT 
      PERCENTILE_CONT(duration_seconds, 0.90)OVER(partition by pu_zone, do_zone, year, month) as median, do_zone, pu_zone, year, month
  FROM a
),
c as (
  select avg(median) as p_90, do_zone, pu_zone, year, month from b
  group by do_zone, pu_zone, year, month
  order by p_90 desc
)
select * from c
where month=11 and year=2019 and pu_zone='Newark Airport'
```

SoHo
```
with a as (
  select do_zone, duration_seconds, pu_zone, year, month from `agile-athlete-449216-m2.dbt_hw_4.fct_fhv_monthly_zone_traveltime_p90`
),
b as (
  SELECT 
      PERCENTILE_CONT(duration_seconds, 0.90)OVER(partition by pu_zone, do_zone, year, month) as median, do_zone, pu_zone, year, month
  FROM a
),
c as (
  select avg(median) as p_90, do_zone, pu_zone, year, month from b
  group by do_zone, pu_zone, year, month
  order by p_90 desc
)
select * from c
where month=11 and year=2019 and pu_zone='SoHo'
```

Yorkville East
```
with a as (
  select do_zone, duration_seconds, pu_zone, year, month from `agile-athlete-449216-m2.dbt_hw_4.fct_fhv_monthly_zone_traveltime_p90`
),
b as (
  SELECT 
      PERCENTILE_CONT(duration_seconds, 0.90)OVER(partition by pu_zone, do_zone, year, month) as median, do_zone, pu_zone, year, month
  FROM a
),
c as (
  select avg(median) as p_90, do_zone, pu_zone, year, month from b
  group by do_zone, pu_zone, year, month
  order by p_90 desc
)
select * from c
where month=11 and year=2019 and pu_zone='Yorkville East'
```