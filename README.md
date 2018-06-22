## About
Terraform module to create TLS certificate from AWS ACM

Features: 
* Multiple domains support (SAN)
* Auto validation using DNS

Limitations:
* all DNS zone should be in the same AWS account

## Usage
 
it's a tricky to pass list of hostnames and its Route 53 zone_ids. The format is a string of comma-separated hostnames list 
and corresponding coma-separated zone_id list (the order in lists should be the same):

```
module "certificate" {
  source    = "github.com/jetbrains-infra/terraform-aws-acm-certificate"
  hostnames = "example.com,example.net" // required
  zone_ids  = "${aws_route53_zone.example_com.id},${aws_route53_zone.example_net.id}" // required
}
```

## Outputs

* `arn` - certificate ARN