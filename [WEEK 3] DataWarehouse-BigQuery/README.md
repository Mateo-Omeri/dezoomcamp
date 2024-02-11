# What is Data Warehouse?

A data warehouse is a centralized repository that is used for the storage and analysis of large volumes of structured and sometimes unstructured data. It is designed to support business intelligence (BI) and reporting activities by providing a unified and optimized view of data from various sources within an organization.

Key characteristics and purposes of a data warehouse include:

* Data Integration: Data warehouses integrate data from multiple sources, such as transactional databases, spreadsheets, and other data repositories. This integration is performed to create a comprehensive and unified view of the organization's data.

* Data Consolidation: A data warehouse consolidates data from different sources into a single, consistent format. This process helps in maintaining data accuracy and consistency across the organization.

* Historical Data Storage: Data warehouses store historical data, allowing organizations to analyze trends and changes over time. This is crucial for decision-making processes and strategic planning.

* Data Transformation: Data stored in a data warehouse is often transformed and cleaned during the integration process to ensure consistency and accuracy. This transformed data is then suitable for analytical purposes.

* Query and Analysis: Data warehouses provide powerful query and analysis capabilities. Business analysts and decision-makers can perform complex queries and generate reports to gain insights into business performance, trends, and patterns.

* Decision Support: Data warehouses are designed to support decision-making processes by providing a reliable and efficient platform for analyzing large datasets. This is essential for business intelligence and data-driven decision-making.

* Scalability: As organizations grow, the amount of data they generate and need to analyze also increases. Data warehouses are designed to scale horizontally or vertically to handle large volumes of data efficiently.

* Security: Data warehouses implement security measures to ensure the confidentiality and integrity of the stored data. Access controls and encryption are often used to protect sensitive information.

# BigQuery

Google BigQuery is a powerful and scalable data warehouse solution that offers real-time analytics, ease of use with SQL-like queries, seamless integration with other GCP services, and strong security features, making it a versatile platform for organizations to derive insights from their data

# Partitions vs Clusters

## Partitions:
* Purpose: Organize data within a table based on a specific column (e.g., date).
* Query Performance: Improve performance by skipping unnecessary partitions during queries.
* Example: Partition a table by date for efficient time-based queries.

## Clusters:
* Purpose: Physically organize data within a table based on one or more columns.
* Query Performance: Enhance performance by grouping similar data together, reducing the amount scanned.
* Example: Cluster a table based on commonly queried columns for improved efficiency.

## Key Differences:
* Partitions: Focus on data organization and query performance based on a chosen column.
* Clusters: Optimize query performance by physically grouping data based on specific columns.
* Granularity: Partitions operate at a coarse level, while clusters operate at a finer level.
* Usage: Partitions are useful for time-based queries; clusters are beneficial for frequently queried columns.

Using both partitioning and clustering can significantly optimize query performance and data organization in BigQuery.

# BigQuery External Table

External Tables in Google BigQuery allow you to access and analyze data stored in external sources, such as Google Cloud Storage, without physically importing the data into the data warehouse. Here's a concise explanation:

* Access External Data: External Tables provide access to data stored in external sources without the need to load them into BigQuery.

* Supported Storage Sources: You can create External Tables with data stored in Google Cloud Storage, Cloud Bigtable, Google Drive, and other compatible storage services.

* Logical View of Data: Despite being external, BigQuery provides a logical view of the data as if it were native tables, allowing you to query them without copying data into the warehouse.

* Performance: Query performance on External Tables may be slightly lower due to accessing external data. However, BigQuery optimizes performance by pushing down filtering and aggregation operations to the external source.

* Partitioning and Clustering: You can define partitioned and clustered External Tables to improve query performance.

# Homework

The goal of this homework is to export data from GCS Bucket into BigQuery using SQL and see how external table and using partition and cluster you can improve query performance. 
You can reproduce my solution following the steps below.

## Technologies

The technologies I chose to carry out the homework are:

Programming language:
* Python

Cloud:
* Google Cloud Platform (GCS, BigQuery)

## Steps

### Step 1: Docker Compose

First of all I choose tu ingest data to GCS Bucket using again Mage. See [week 2](https://github.com/Mateo-Omeri/dezoomcamp/tree/main/%5BWEEK%202%5D%20Orchestration-MAGE) for more details about Mage.

Here my Data Loader for this homework:

```
import io
import pandas as pd
import pyarrow.parquet as pa
import requests
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_api(*args, **kwargs):

    urls = ['https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-01.parquet',
            'https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-02.parquet',
            'https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-03.parquet',
            'https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-04.parquet',
            'https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-05.parquet',
            'https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-06.parquet',
            'https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-07.parquet',
            'https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-08.parquet',
            'https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-09.parquet',
            'https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-10.parquet',
            'https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-11.parquet',
            'https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-12.parquet']
    
    taxi_dtypes = {
        'VendorID': pd.Int64Dtype(),
        'passenger_count': pd.Int64Dtype(),
        'trip_distance': float,
        'RatecodeID':pd.Int64Dtype(),
        'store_and_fwd_flag':str,
        'PULocationID':pd.Int64Dtype(),
        'DOLocationID':pd.Int64Dtype(),
        'payment_type': pd.Int64Dtype(),
        'fare_amount': float,
        'extra':float,
        'mta_tax':float,
        'tip_amount':float,
        'tolls_amount':float,
        'improvement_surcharge':float,
        'total_amount':float,
        'congestion_surcharge':float
    }

    # native date parsing 
    parse_dates = ['lpep_pickup_datetime', 'lpep_dropoff_datetime']
    df = pd.DataFrame()

    for url in urls:
        url_df = pd.read_parquet(
            url, engine='pyarrow'
        )
        df = pd.concat([df, url_df], ignore_index=True)

    df.to_csv('temp.csv', index=False)
    ds = pd.read_csv('temp.csv',sep=',', dtype=taxi_dtypes, parse_dates=parse_dates)
    return ds


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
```

### Step 2: GCP

Written all queries that i need for homework. You can find them [here]()