resource "aws_acm_certificate" "default" {
  domain_name = "${local.main_domain}"
  subject_alternative_names = ["${local.alternative_names}"]
  validation_method = "DNS"
}

resource "aws_route53_record" "proof" {
  count   = "${local.hostname_count}"
  name    = "${lookup(aws_acm_certificate.default.domain_validation_options[count.index], "resource_record_name")}"
  type    = "${lookup(aws_acm_certificate.default.domain_validation_options[count.index], "resource_record_type")}"
  zone_id = "${element(var.zone_ids, count.index)}"
  records = ["${lookup(aws_acm_certificate.default.domain_validation_options[count.index], "resource_record_value")}"]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "default" {
  certificate_arn = "${aws_acm_certificate.default.arn}"
  validation_record_fqdns = ["${aws_route53_record.proof.fqdn}"]
}