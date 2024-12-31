terraform {
  backend "gcs" {
    bucket = "tf-bucket-3211"       # Specify the name of your GCS bucket to store state
    prefix = "terraform/state"              # Path within the bucket where state will be stored
  }
}