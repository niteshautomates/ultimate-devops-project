terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}

data "aws_region" "current" {}
resource "aws_vpc_ipam" "vpc_ipam" {
    description = "IPAM for VPC"
    operating_regions {
        region_name = aws_region.current.region_name
    }
}