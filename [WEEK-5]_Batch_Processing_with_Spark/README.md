# Batch Processing 

Batch processing is a data processing technique where data is collected, processed, and stored in chunks or batches at scheduled intervals. In this approach, data is grouped together, and the processing occurs without the need for real-time interaction. Batch processing is commonly used for handling large volumes of data efficiently, making it suitable for tasks like data transformation, analysis, and reporting. It contrasts with real-time or streaming processing, as batch processing typically involves processing data in discrete sets rather than continuously as it arrives.

# Spark

Apache Spark is an open-source, distributed computing system designed for big data processing and analytics. It provides an advanced and fast in-memory data processing engine for large-scale data processing tasks. Spark supports various programming languages, including Scala, Java, Python, and R.

Key features of Apache Spark include:

* Speed: Spark enables faster data processing through in-memory computing, reducing the need to write intermediate results to disk.

* Ease of Use: It offers high-level APIs in multiple programming languages, making it accessible to a broad audience, and provides built-in libraries for diverse tasks like SQL queries, machine learning, graph processing, and streaming.

* Versatility: Spark supports various data processing tasks, including batch processing, iterative algorithms, interactive queries, and streaming. This versatility makes it suitable for a wide range of applications.

* Resilience: Spark provides fault tolerance through resilient distributed datasets (RDDs), which are fault-tolerant collections of data that can be processed in parallel.

* Scalability: It can scale horizontally across a cluster of machines, making it well-suited for processing large datasets across multiple nodes.

* Integration: Spark can be easily integrated with other big data tools and frameworks, such as Hadoop Distributed File System (HDFS), Hive, and more.

# PySpark

PySpark is the Python API for Apache Spark, an open-source, distributed computing system designed for big data processing and analytics. PySpark allows developers to use the Spark framework with the Python programming language. It provides a high-level API for distributed data processing, making it more accessible to Python developers.

Key features and aspects of PySpark include:

* Ease of Use: PySpark enables Python developers to leverage the capabilities of Spark for large-scale data processing without having to switch to other programming languages.

* SparkContext: PySpark uses a SparkContext object to connect to a Spark cluster, allowing the execution of parallelized operations on distributed datasets.

* DataFrame API: PySpark includes a DataFrame API, similar to Pandas DataFrames, for working with structured data. This API simplifies data manipulation tasks and supports SQL-like queries.

* RDDs (Resilient Distributed Datasets): While PySpark's DataFrame API is higher-level and user-friendly, RDDs provide a lower-level API for distributed data processing, offering fault tolerance through lineage information.

* Integration with Python Libraries: PySpark can be integrated with various Python libraries, such as NumPy, Pandas, and scikit-learn, allowing data scientists to combine the power of Spark with their preferred Python tools.

* Spark SQL: PySpark supports Spark SQL, enabling the execution of SQL queries on structured data within Spark, providing a convenient way to interact with data using SQL.

# Homework

The goal of this homework is to process and query trips data using Spark. In order to complete the homework I decided to use GCP environment, so I stored the data into GCS bucket and I used Dataproc cluster and run my PySpark job there. Dataproc is a managed cloud service provided by Google Cloud Platform (GCP) for running Apache Spark and Apache Hadoop clusters. It simplifies the process of deploying, managing, and scaling distributed data processing frameworks on the cloud.
