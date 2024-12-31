terraform {
  required_providers {
    google ={
        source = "hashicorp/google"
        version = "~>=6.0"
    }
  }
}


provider "google" {
  project = var.projectid
  region  = var.regions[0]  # Set the default region if needed (used for provider context)
}

provider "google" {
  alias   = "region2"
  project = var.projectid
  region  = var.regions[1]  # Use second region from the variable list
}