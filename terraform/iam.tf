# IAM roles and bindings configuration

# Create a list of roles
variable "roles" {
  type    = list(string)
  default = [
    "roles/storage.admin",
    "roles/bigquery.admin",
    "roles/iam.serviceAccountUser",
    "roles/composer.admin",
    "roles/composer.worker",
    # Add other roles as needed
  ]
}

resource "google_project_iam_member" "service_account_roles" {
  count   = length(var.roles)
  project = var.project

  # Service account email
  member = "serviceAccount:gcp-demo-service-account@${var.project}.iam.gserviceaccount.com"

  # Assign roles
  role = var.roles[count.index]
}
