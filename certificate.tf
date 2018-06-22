resource "aws_acm_certificate" "default" {
  domain_name = "${local.main_domain}"
  subject_alternative_names = ["${local.alternative_names}"]
  validation_method = "DNS"
}

resource "aws_route53_record" "proof" {
  count   = "${local.hostname_count}"
  name    = "${element(aws_acm_certificate.default.domain_validation_options.*.resource_record_name, count.index)}"
  type    = "${element(aws_acm_certificate.default.domain_validation_options.*.resource_record_type, count.index)}"
  zone_id = "${element(var.zone_ids, count.index)}"
  records = ["${element(aws_acm_certificate.default.domain_validation_options.*.resource_record_value, count.index)}"]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "default" {
  certificate_arn = "${aws_acm_certificate.default.arn}"
  validation_record_fqdns = ["${aws_route53_record.proof.fqdn}"]
}