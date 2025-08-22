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

#************************** Compute VPC **************************#
module "compute_vpc" {
  source      = "../modules/vpc"
  environment = var.environment

}

# Bastion Server
module "bastion-server" {
  count                 = 1
  source                = "../modules/ec2"
  name                  = "bastian-server-${count.index}"
  key_name              = var.key_name
  vpc_security_group_id = module.compute_vpc.vpc_security_group_id
  subnet_id             = module.compute_vpc.subnet_id

}