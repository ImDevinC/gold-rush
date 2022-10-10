resource "aws_acm_certificate" "gnomebytes_com" {
  private_key       = data.aws_kms_secrets.acm.plaintext["acm_priv_key"]
  certificate_body  = data.aws_kms_secrets.acm.plaintext["acm_cert"]
  certificate_chain = data.aws_kms_secrets.acm.plaintext["acm_chain"]
  provider          = aws.useast1
}

data "aws_kms_secrets" "acm" {
  secret {
    name    = "acm_cert"
    payload = local.acm_cert
  }

  secret {
    name    = "acm_priv_key"
    payload = local.acm_priv_key
  }

  secret {
    name    = "acm_chain"
    payload = local.acm_chain
  }
}

resource "aws_acm_certificate" "main" {
  domain_name       = local.domain_name
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
  provider = aws.useast1
}
