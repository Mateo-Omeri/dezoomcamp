locals {
  data_lake_bucket = "project-datalake"
}

variable "project" {
  description = "Project"
  default     = "data-zoomcamp-410401"
}

variable "region" {
  description = "Region for the GCP resources. Choose the below with the desire region"
  default     = "EU"
}

variable "BigQuery_dataset" {
  description = "BigQuery Dataset. This dataset will receive the clean data from the dat lake (GCS)"
  default     = "project_dataset"
}

variable "storage_class" {
  description = "Storage class type for the bucket"
  default     = "STANDARD"
}