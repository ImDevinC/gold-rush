terraform {
  backend "gcs" {
    bucket = "imdevinc-terraform-state"
  }
}

provider "google" {
  project = "imdevinc"
  region  = "us-west2"
  zone    = "us-west2-a"
}

