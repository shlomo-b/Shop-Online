# Save the file terraform.tfstate in S3.

terraform {
  backend "s3" {
    bucket = "shlomo-project-ci-cd"
    key    = "first-project-ci-cd/terraform.tfstate"
    region = "us-east-1"
  }
}


