module "kms_key" {
  source = "cloudposse/kms-key/aws"
  alias  = "alias/gold-rush"
}
