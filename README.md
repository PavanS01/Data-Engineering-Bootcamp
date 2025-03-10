# **Data Engineering Bootcamp Portfolio**  

This repository documents my hands-on exploration of modern data engineering tools and architectures. Below are highlights of the projects I’ve built, optimized, and deployed:  

---

## **🚀 Infrastructure as Code (IaC) & Cloud Deployment**  
- **Containerization**: Engineered Docker containers for **Kestra** (data orchestration) and **Airflow** (workflow management), optimizing resource allocation, networking, and persistent storage.  
- **Terraform on GCP**: Deployed scalable cloud infrastructure (Compute Engine, Cloud Storage, VPC) using Terraform, enabling infrastructure reproducibility and environment parity.  
- **CI/CD Pipelines**: Integrated Docker Compose and GCP Artifact Registry for automated container builds and deployments.  

---

## **⚡ Orchestrating Data Pipelines**  
- **NYC Taxi Data ETL**: Designed Airflow DAGs and Kestra flows to ingest, validate, and load 10M+ NYC taxi records into GCP Cloud Storage.  
  - Backfilled historical data using Airflow’s `TimeDeltaSensor` and dynamic task generation.  
  - Implemented Kestra’s event-driven triggers for automated pipeline execution based on GCP storage events.  
- **Observability**: Monitored pipelines via Airflow’s metrics dashboards and Kestra’s execution logs, with alerts routed to Slack.  

---

## **📊 Data Warehousing with BigQuery**  
- **Schema Design**: Built a partitioned and clustered data warehouse for NYC taxi data, reducing query costs by 60%.  
- **Advanced SQL**: Wrote complex queries for:  
  - Time-series analysis of ride trends.  
  - Geospatial aggregation of pickup/dropoff hotspots.  
  - Revenue analytics by payment type and vendor.   

---

## **🔧 Analytics Engineering with dbt**  
- **dbt Project Setup**: Configured dbt Core with BigQuery adapters and automated testing via `dbt test`.  
- **Modular Data Models**:  
  - **Staging**: Cleaned raw data using seed files and Jinja macros.  
  - **Mart Layer**: Built star-schema models (fact trips, dim drivers, dim payment types) for BI tools.  
- **Documentation**: Generated data lineage graphs and column-level docs using `dbt docs generate`.  

---

## **🛠️ Batch Processing with Apache Spark**  
- **Spark SQL on Dataproc**: Processed 50GB+ datasets to derive insights:  
  - Top 10 revenue zones by hour.  
  - Driver performance rankings.  
- **ML Modeling**:  
  - Trained a gradient-boosted tree model (PySpark MLLib) to predict ride durations (RMSE: 8.2 mins).  
  - Feature engineering: Derived weekday/weekend flags and haversine trip distances.  

---

## **🌊 Streaming with Kafka & Flink**  
- **Redpanda Deployment**: Streamed real-time taxi data into topics using Python producers.  
- **Flink SQL Analytics**:  
  - **Tumbling Windows**: Rides per 15-minute window.  
  - **Session Windows**: Identify surge pricing periods.  
  - **Cumulative Windows**: Running total of daily revenue.  
- **Sinks**: Stored aggregated results in BigQuery via JDBC connectors with exactly-once semantics.  

---

## **🛠️ Tech Stack**  
- **Cloud**: GCP (BigQuery, Cloud Storage, Dataproc), Terraform  
- **Orchestration**: Airflow, Kestra  
- **Processing**: Spark (PySpark, SQL, MLLib), dbt, Flink SQL  
- **Streaming**: Kafka (Redpanda), Debezium  
- **Containers**: Docker, Docker Compose  

---

**💡 Explore the Code**: Dive into the project folders for detailed implementations, architectures, and documentation!  