# Data sources for the SRE Challenge 2025 infrastructure

data "aws_availability_zones" "available" {
  state = "available"
}

#data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
