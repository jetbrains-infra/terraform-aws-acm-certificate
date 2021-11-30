## About
Terraform module to create TLS certificate in the AWS ACM service.

Features: 
* Multiple domains support (SAN)
* Auto validation using DNS

**NB!**: You should have permissions to create RRs in all specified DNS zones.

## Usage

```hcl
module "certificate" {
  source  = "../"
  name    = "test_certificate"
  aliases = [
    { 
      hostname = "example.com", 
      zone_id  = data.aws_route53_zone.example_com.zone_id 
    },
    { 
      hostname = "addon.example.com", 
      zone_id  = data.aws_route53_zone.example_com.zone_id 
    },
    { 
      hostname = "example.net", 
      zone_id  = data.aws_route53_zone.example_net.zone_id 
    }
  ]
  
  providers = {
    aws = aws.us // Use `aws` provider with `us-east-1` reagion to issue a certificate for a Cloudfront distribution 
  }
}
```

## Outputs

* `arn` - certificate ARN
