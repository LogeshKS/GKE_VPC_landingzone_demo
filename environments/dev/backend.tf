terraform {
  backend "gcs" {
    bucket = var.backend_bucket_name        # Specify the name of your GCS bucket to store state
    prefix = "terraform/state"              # Path within the bucket where state will be stored
    credentials = var.gcp_credentials_file  # Path to your service account JSON credentials file
  }
}