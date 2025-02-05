Create External Table
```
CREATE EXTERNAL TABLE `agile-athlete-449216-m2.hw3.yellow_taxi_2024`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://ny_taxi_import_pops/yellow_2024/*.parquet']
);
```

Create a (regular/materialized) table
```
CREATE TABLE `agile-athlete-449216-m2.hw3.yellow_taxi_2024_regular` AS
SELECT * FROM `agile-athlete-449216-m2.hw3.yellow_taxi_2024`;
```

Question 1: What is count of records for the 2024 Yellow Taxi Data?
```
SELECT COUNT(*) as row_count FROM `agile-athlete-449216-m2.hw3.yellow_taxi_2024`
```

Question 2: Write a query to count the distinct number of PULocationIDs for the entire dataset on both the tables.
What is the estimated amount of data that will be read when this query is executed on the External Table and the Table?
```
SELECT COUNT(DISTINCT(PULocationID)) as row_count FROM `agile-athlete-449216-m2.hw3.yellow_taxi_2024`

SELECT COUNT(DISTINCT(PULocationID)) FROM `agile-athlete-449216-m2.hw3.yellow_taxi_2024_regular`
```

Question 3: Write a query to retrieve the PULocationID from the table (not the external table) in BigQuery. Now write a query to retrieve the PULocationID and DOLocationID on the same table. Why are the estimated number of Bytes different?
```
SELECT COUNT(DISTINCT(PULocationID)) FROM `agile-athlete-449216-m2.hw3.yellow_taxi_2024_regular`

SELECT COUNT(DISTINCT(PULocationID)), COUNT(DISTINCT(DOLocationID))  FROM `agile-athlete-449216-m2.hw3.yellow_taxi_2024_regular`
```

Question 4. How many records have a fare_amount of 0? 
```
SELECT COUNT(*)  FROM `agile-athlete-449216-m2.hw3.yellow_taxi_2024_regular`
WHERE fare_amount=0
```

Question 5: Partitioned and Clustered Table
```
CREATE TABLE `agile-athlete-449216-m2.hw3.yellow_taxi_2024_regular_partitioned`
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID
AS
SELECT * FROM `agile-athlete-449216-m2.hw3.yellow_taxi_2024`;
```

Question 6: Write a query to retrieve the distinct VendorIDs between tpep_dropoff_datetime 2024-03-01 and 2024-03-15 (inclusive)

Use the materialized table you created earlier in your from clause and note the estimated bytes. Now change the table in the from clause to the partitioned table you created for question 5 and note the estimated bytes processed. What are these values?
```
SELECT DISTINCT(VendorID) FROM `agile-athlete-449216-m2.hw3.yellow_taxi_2024_regular` 
WHERE tpep_dropoff_datetime>=TIMESTAMP('2024-03-01') AND tpep_dropoff_datetime<=TIMESTAMP('2024-03-15')

SELECT DISTINCT(VendorID) FROM `agile-athlete-449216-m2.hw3.yellow_taxi_2024_regular_partitioned` 
WHERE tpep_dropoff_datetime>=TIMESTAMP('2024-03-01') AND tpep_dropoff_datetime<=TIMESTAMP('2024-03-15')
```

