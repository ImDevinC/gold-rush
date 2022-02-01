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

resource "google_storage_bucket" "main" {
  name                        = "gold-rush"
  location                    = "US"
  force_destroy               = true
  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
  }
}

resource "google_compute_backend_bucket" "main" {
  name        = "gold-rush"
  bucket_name = google_storage_bucket.main.name
}
