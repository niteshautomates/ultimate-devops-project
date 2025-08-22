terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}

data "aws_region" "current" {}
#*************************** VPC IPAM **************************#
resource "aws_vpc_ipam" "compute_vpc_ipam" {
  description = "IPAM for VPC"
  operating_regions {
    region_name = data.aws_region.current.name
  }
}

#*************************** VPC IPAM Pool **************************#
resource "aws_vpc_ipam_pool" "compute_vpc_ipam_pool" {
  address_family = "ipv4"
  description    = "Compute VPC IPAM Pool"
  ipam_scope_id  = aws_vpc_ipam.compute_vpc_ipam.private_default_scope_id
  locale         = data.aws_region.current.name
  tags = {
    Name        = "Compute VPC IPAM Pool"
    Environment = var.environment
    Project     = "ultimate-devops-project"
    ManagedBy   = "Terraform"

  }
}

#*************************** VPC IPAM Pool CIDR **************************#
resource "aws_vpc_ipam_pool_cidr" "compute_vpc_pool_cidr" {
  ipam_pool_id = aws_vpc_ipam_pool.compute_vpc_ipam_pool.id
  cidr         = "192.168.0.0/16"
}

#*************************** AWS VPC**************************#

resource "aws_vpc" "compute_vpc" {
  ipv4_ipam_pool_id    = aws_vpc_ipam_pool.compute_vpc_ipam_pool.id
  ipv4_netmask_length  = 17
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = "Compute VPC"
    Environment = var.environment
    Project     = "ultimate-devops-project"
    ManagedBy   = "Terraform"
  }
  depends_on = [aws_vpc_ipam_pool_cidr.compute_vpc_pool_cidr]
}

#*************************** compute VPC private subnet **************************#

resource "aws_subnet" "compute_vpc_private_subnet" {
  vpc_id            = aws_vpc.compute_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.compute_vpc.cidr_block, 8, 0)
  availability_zone = format("%sa", data.aws_region.current.name)
}

#*************************** compute VPC public subnet **************************#
resource "aws_subnet" "compute_vpc_public_subnet" {
  vpc_id                                      = aws_vpc.compute_vpc.id
  cidr_block                                  = cidrsubnet(aws_vpc.compute_vpc.cidr_block, 8, 1)
  availability_zone                           = format("%sa", data.aws_region.current.name)
  map_public_ip_on_launch                     = true

  enable_resource_name_dns_a_record_on_launch = true
}

#*************************** Security Groups **************************#

resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Security group for bastion host"
  vpc_id      = aws_vpc.compute_vpc.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
  }
}
