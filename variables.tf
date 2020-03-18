variable "project" {
  description = "Project tag."
}

variable "hostnames" {
  description = "Certificate hostname list. The first is expected as the main domain, other ones are an alternative names."
  type        = list(string)
}

variable "zone_ids" {
  description = "Route 53 domain zone id list. Each id is corresponding to an item in the hostname list."
  type        = list(string)
}

variable "region" {
  description = "The region where certificate would be issued. Use `us-east-1` for Cloudfront distribution certificates."
  default     = "eu-west-1"
}

locals {
  project           = var.project
  region            = var.region
  purpose           = local.region == "us-east-1" ? "CloudFront" : "LoadBalancer"
  main_domain       = element(var.hostnames, 0)
  alternative_names = slice(var.hostnames, 1, length(var.hostnames))
  hostname_count    = length(var.hostnames)
}