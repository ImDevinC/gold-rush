module "cloudfront" {
  source = "terraform-aws-modules/cloudfront/aws"
  aliases = [
    local.domain_name,
    "www.${local.domain_name}"
  ]
  price_class                   = "PriceClass_100"
  create_origin_access_identity = true
  default_root_object           = "index.html"
  origin_access_identities = {
    bucket = "Cloudfront to S3"
  }
  origin = {
    bucket = {
      domain_name = module.bucket.s3_bucket_bucket_domain_name
      s3_origin_config = {
        origin_access_identity = "bucket"
      }
    }
  }
  default_cache_behavior = {
    target_origin_id       = "bucket"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    query_string           = false
  }
  custom_error_response = {
    404 = {
      error_code         = 404
      response_code      = 404
      response_page_path = "/index.html"
    }
  }
  viewer_certificate = {
    acm_certificate_arn = aws_acm_certificate.main.arn
    ssl_support_method  = "sni-only"
  }
}
