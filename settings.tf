provider "aws" {
  region  = var.region
  default_tags {
    tags = {
      Module = "ACM certificate"
      ModuleVersion = "v0.4.0"
    }
  }
}

terraform {
  required_version = ">=1.0"
}