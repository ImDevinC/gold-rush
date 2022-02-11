terraform {
  backend "s3" {
    bucket = "imdevinc-tf-storage"
    region = "us-west-1"
    key    = "gold-rush"
  }
}

provider "google" {
  project = "imdevinc"
  region  = "us-west2"
  zone    = "us-west2-a"
}
