# terraform {
#   backend "s3" {
#     bucket = "imdevinc-tf-storage"
#     key    = "gold-rush"
#     region = "us-west-1"
#   }
# }

provider "aws" {
  region = "us-west-2"
}

provider "aws" {
  region = "us-east-1"
  alias  = "useast1"
}
