locals {
  common_tags = merge(var.tags,
    { Environment = var.environment
      Project     = "ultimate-devops-project"
  MangedBy = "Terraform" })
}


module "kms" {
  source       = "../modules/kms"
  tags         = local.common_tags
  project_name = var.project_name
}

module "s3" {
  source             = "../modules/S3"
  tags               = local.common_tags
  kms_master_key_arn = module.kms.kms_master_key_arn
}
