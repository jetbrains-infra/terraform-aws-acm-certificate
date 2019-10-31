provider "aws" {
  region = var.region
  version = "~>2.7.0"
}

terraform {
  required_version = ">=0.12"
}