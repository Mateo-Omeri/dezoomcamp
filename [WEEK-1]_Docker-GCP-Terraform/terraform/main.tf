terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.6.0"
    }
  }
}

provider "google" {
  project     = var.project
  region      = var.region
  // credentials = file(var.credentials)  # Use this if you do not want to set env-var GOOGLE_APPLICATION_CREDENTIALS
}

#Data Lake
resource "google_storage_bucket" "data-lake-bucket" {
  name          = "${local.data_lake_bucket}_${var.project}"
  location      = var.region
  
  # Optional, but recommended settings:
  storage_class = var.storage_class
  uniform_bucket_level_access = true


  lifecycle_rule {
    condition {
      age = 60
    }
    action {
      type = "Delete"
    }
  }

  force_destroy = true
}

#DataWarehouse
resource "google_bigquery_dataset" "dataset" {
  dataset_id = var.BigQuery_dataset
  project    = var.project
  location   = var.region
}