locals {
  common_tags = merge(var.tags,
    { Environment = var.environment
      Project     = "ultimate-devops-project"
  MangedBy = "Terraform" })
}


# Create IAM Roles

module "IAM" {
  source = "../modules/IAM"
   assume_role_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com" # Example: Allow EC2 to assume this role
        }
        Action = "sts:AssumeRole"
      },
    ]
  }
  tags = local.common_tags
}
# Create KMS Keys
module "kms" {
  source       = "../modules/kms"
  tags         = local.common_tags
  project_name = var.project_name
}

# Create S3 buckets for storing statefiles and locking
module "s3" {
  source             = "../modules/S3"
  tags               = local.common_tags
  kms_master_key_arn = module.kms.kms_master_key_arn
}
