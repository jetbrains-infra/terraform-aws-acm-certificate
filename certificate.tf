resource "aws_acm_certificate" "default" {
  domain_name               = local.main_domain
  subject_alternative_names = local.additional_aliases
  validation_method         = "DNS"
  tags                      = local.tags
}

resource "aws_route53_record" "proof" {
  for_each        = local.aliases
  name            = lookup({ for i in aws_acm_certificate.default.domain_validation_options : "result" => i["resource_record_name"] if i["domain_name"] == each.key }, "result")
  type            = lookup({ for i in aws_acm_certificate.default.domain_validation_options : "result" => i["resource_record_type"] if i["domain_name"] == each.key }, "result")
  records         = [lookup({ for i in aws_acm_certificate.default.domain_validation_options : "result" => i["resource_record_value"] if i["domain_name"] == each.key }, "result")]
  zone_id         = each.value
  ttl             = 60
  allow_overwrite = true
  depends_on      = [aws_acm_certificate.default]
}

resource "aws_acm_certificate_validation" "default" {
  certificate_arn         = aws_acm_certificate.default.arn
  validation_record_fqdns = [for record in aws_route53_record.proof: record.fqdn]
  depends_on              = [aws_route53_record.proof]
}