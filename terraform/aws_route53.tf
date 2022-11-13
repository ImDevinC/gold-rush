module "zones" {
  source = "terraform-aws-modules/route53/aws//modules/zones"
  zones = {
    (local.domain_name) = {}
  }
}

locals {
  records = [
    for dvo in aws_acm_certificate.main.domain_validation_options : {
      name    = dvo.resource_record_name
      records = [dvo.resource_record_value]
      type    = dvo.resource_record_type
    }
  ]
}

module "records" {
  source    = "terraform-aws-modules/route53/aws//modules/records"
  zone_name = keys(module.zones.route53_zone_zone_id)[0]
  records = [
    {
      name = ""
      type = "A"
      alias = {
        name    = module.cloudfront.cloudfront_distribution_domain_name
        zone_id = module.cloudfront.cloudfront_distribution_hosted_zone_id
      }
    },
    {
      name               = local.records[0].name
      records            = local.records[0].records
      type               = local.records[0].type
      full_name_override = true
      ttl                = 300
    },
    {
      name    = "www"
      type    = "CNAME"
      records = [local.domain_name]
      ttl     = 3600
    }
  ]

  depends_on = [module.zones]
}
