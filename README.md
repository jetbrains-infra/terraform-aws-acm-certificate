## About
Terraform module to create TLS certificate in AWS ACM

Features: 
* Multiple domains support (SAN)
* Auto validation using DNS

Limitations:
* All DNS zone should be in the same AWS account

## Usage
 
it's a tricky to pass list of hostnames and its Route 53 zone_ids. The format is a hostnames list 
and corresponding zone_id list (the order in lists should be the same):

```
module "certificate" {
  source    = "github.com/jetbrains-infra/terraform-aws-acm-certificate"
  hostnames = [
    "example.com",
    "example.net"
  ]
  zone_ids  = [
    "${aws_route53_zone.example_com.id}",
    "${aws_route53_zone.example_net.id}"
  ]
  region    = "us-east-1"
}
```

## Outputs

* `arn` - certificate ARN