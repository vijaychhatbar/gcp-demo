terraform {
  required_version = ">= 1.0"
  backend "local" {
    path = "terraform.tfstate"
  }
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}


provider "google" {
  project     = var.project
  region      = var.region
  credentials = file(var.gcp_credentials) # Use this if you do not want to set env-var GOOGLE_APPLICATION_CREDENTIALS
}


resource "google_storage_bucket" "gcp_demo_bucket" {
  name                        = var.gcp_bucket_dataset
  location                    = var.region
  storage_class               = var.storage_class
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 365 // days
    }

  }

  force_destroy = true
  depends_on    = [google_project_iam_member.service_account_roles]
}


resource "google_bigquery_dataset" "dataset_raw" {
  dataset_id                 = var.gcp_bq_dataset_raw
  project                    = var.project
  location                   = var.region
  delete_contents_on_destroy = true
  depends_on                 = [google_project_iam_member.service_account_roles]
}

resource "google_composer_environment" "composer_env" {
  name    = var.cloud_composer
  project = var.project
  region  = var.region # Change to your desired region

  config {
    node_count = 3
    node_config {
      disk_size_gb    = 30
      machine_type    = "n1-standard-1"
      service_account = "gcp-demo-service-account@gcp-demo-398309.iam.gserviceaccount.com"
      zone            = "us-central1-c"
    }
    software_config {
      image_version   = "composer-1.20.12-airflow-2.3.4" # Use the desired Composer image version
      scheduler_count = 3
    }
  }
  depends_on = [google_project_iam_member.service_account_roles]
}
