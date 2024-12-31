terraform {
  backend "gcs" {
    bucket = "tf-bucket-3211"       # Specify the name of your GCS bucket to store state
    prefix = "terraform/state"              # Path within the bucket where state will be stored
    credentials = file("/home/logesh/Devops/dulcet-glazing-444913-i8-cf78e067d898.json")  # Path to your service account JSON credentials file
  }
}