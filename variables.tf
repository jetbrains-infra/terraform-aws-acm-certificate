variable "name" {
  description = "Name tag"
}
variable "aliases" {
  description = "List of hostnames with their domain zone ids. The first is expected as the main domain, other ones are an alternative names."
  type        = list(object({ hostname = string, zone_id = string }))
}

locals {
  aliases            = zipmap(var.aliases[*].hostname, var.aliases[*].zone_id)
  main_domain        = element(var.aliases, 0)["hostname"]
  additional_aliases = [for x in var.aliases : x["hostname"] if x["hostname"] != local.main_domain]
  hostname_count     = length(var.aliases)
  tags = {
    Name          = var.name
    Module        = "ACM certificate"
    ModuleVersion = "v0.6.0"
  }
}
