terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.18.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials)
  project = "agile-athlete-449216-m2"
  region  = "us-central1"
}

resource "google_bigquery_dataset" "demo_dataset" {
  dataset_id = "demo_dataset"
}

resource "google_storage_bucket" "demo-bucket" {
  name          = "popsdemobucketbootcamp"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 3
    }
    action {
      type = "Delete"
    }
  }
}