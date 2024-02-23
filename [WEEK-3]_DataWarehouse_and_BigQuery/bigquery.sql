#Create External Table
CREATE OR REPLACE EXTERNAL TABLE `your-project.your-schema.your-table`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://your-bucket/your-folder/your-file.parquet']
);

#Check external table data
SELECT COUNT(*) FROM data-zoomcamp-410401.ny_taxi.nytaxi_external_green_2022;

#Create a table form external table
CREATE OR REPLACE TABLE `your-project.your-schema.your-table` AS
SELECT * FROM data-zoomcamp-410401.ny_taxi.nytaxi_external_green_2022;

#Count distinct PULocationIDs in the external table
SELECT COUNT(DISTINCT PULocationID) AS distinct_PULocationIDs
FROM `your-project.your-schema.your-table`;

#Count distinct PULocationIDs in the materialized table
SELECT COUNT(DISTINCT PULocationID) AS distinct_PULocationIDs
FROM `your-project.your-schema.your-table`;

#Count records have a fare_amount of 0
SELECT COUNT(*) AS num_records_with_zero_fare
FROM `your-project.your-schema.your-table`
WHERE fare_amount = 0;

#Add column to convert column in date
ALTER TABLE `your-project.your-schema.your-table`
ADD COLUMN lpep_pickup_datetime_converted TIMESTAMP;

UPDATE `your-project.your-schema.your-table`
SET
  lpep_pickup_datetime_converted = PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', lpep_pickup_datetime)
WHERE lpep_pickup_datetime IS NOT NULL;

#Create partitioned and clustered table
CREATE TABLE `your-project.your-schema.your-table_partitioned_and_clustered`
PARTITION BY DATE(lpep_pickup_datetime_converted)
CLUSTER BY PULocationID AS
SELECT *
FROM `your-project.your-schema.your-table`;

#Query to retrieve the distinct PULocationID between lpep_pickup_datetime 06/01/2022 and 06/30/2022
SELECT DISTINCT PULocationID
FROM `your-project.your-schema.your-table_partitioned_and_clustered`
WHERE lpep_pickup_datetime_converted >= TIMESTAMP('2022-06-01') AND lpep_pickup_datetime_converted <= TIMESTAMP('2022-06-30');

SELECT DISTINCT PULocationID
FROM `your-project.your-schema.your-table`
WHERE lpep_pickup_datetime_converted >= TIMESTAMP('2022-06-01') AND lpep_pickup_datetime_converted <= TIMESTAMP('2022-06-30');


