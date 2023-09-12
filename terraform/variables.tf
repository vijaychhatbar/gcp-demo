variable "project" {
  description = "Your GCP Project ID"
  default = "gcp-demo-398309"
}

variable "gcp_credentials" {
  description = "JSON service account credentials"
  default     = "/home/vijay/.credentials/credentials.json"
  type        = string
}


variable "region" {
  description = "Region where GCP resources will be created."
  default     = "us-central1"
  type        = string
}

variable "gcp_bucket_dataset" {
  description = "Bucket name for storage"
  default     = "gcp-demo-bucket-398309"
  type        = string
}

variable "storage_class" {
  description = "Storage class type for your bucket."
  default     = "STANDARD"
}

variable "gcp_bq_dataset_raw" {
  description = "Dataset for storing data in BQ."
  default     = "dataset_raw"
  type        = string
}

variable "cloud_composer" {
  description = "Cloud composer config for Airflow."
  default = "cloud-composer-test"
  type  = string
}
