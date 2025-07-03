terraform {
  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        region = "ap-south-1"

    }
    random = {
        source  = "hashicorp/random"
        version = "~> 3.0"
      region = "ap-south-1"
    }
  }
}