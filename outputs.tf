output "arn" {
  description = "Certificate arn"
  value = "${aws_acm_certificate.default.arn}"
}