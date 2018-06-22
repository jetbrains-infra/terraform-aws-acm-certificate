variable "hostnames" {}
variable "zone_ids" {}
variable "region" {
  default = "eu-west-1"
}

locals {
  main_domain       = "${element(split(",", var.hostnames), 0)}"
  alternative_names = "${slice(split(",", var.hostnames), 1, length(split(",", var.hostnames)))}"
  hostname_count    = "${length(split(",", var.hostnames))}"
}

provider "aws" {
  region = "${var.region}"
}