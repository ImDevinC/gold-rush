resource "aws_acm_certificate" "main" {
  domain_name       = local.domain_name
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
  provider = aws.useast1
}
