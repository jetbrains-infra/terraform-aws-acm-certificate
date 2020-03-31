variable "name" {
  description = "Name tag."
}
variable "aliases" {
  description = "List of hostnames with their domain zone ids. The first is expected as the main domain, other ones are an alternative names."
  type        = list(object({ hostname = string, zone_id = string }))
}
variable "region" {
  description = "The region where certificate would be issued. Use `us-east-1` for Cloudfront distribution certificates."
  default     = "eu-west-1"
}
variable "tags" {
  description = "Tags."
  type        = map(string)
  default     = {}
}

locals {
  aliases            = zipmap(var.aliases[*].hostname, var.aliases[*].zone_id)
  main_domain        = element(var.aliases, 0)["hostname"]
  additional_aliases = [for x in var.aliases : x["hostname"] if x["hostname"] != local.main_domain]
  region             = var.region
  hostname_count     = length(var.aliases)

  tags = merge({
    Name   = var.name,
    Module = "ACM certificate"
  }, var.tags)
}