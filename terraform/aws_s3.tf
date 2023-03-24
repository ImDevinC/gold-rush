module "bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "imdevinc-gold-rush"
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = module.kms_key.key_id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${module.bucket.s3_bucket_arn}/*"]

    principals {
      type        = "AWS"
      identifiers = module.cloudfront.cloudfront_origin_access_identity_iam_arns
    }
  }

  statement {
    actions   = ["s3:*"]
    resources = ["${module.bucket.s3_bucket_arn}", "${module.bucket.s3_bucket_arn}/*"]
    effect    = "Deny"
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = [false]
    }
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = module.bucket.s3_bucket_id
  policy = data.aws_iam_policy_document.s3_policy.json
}
