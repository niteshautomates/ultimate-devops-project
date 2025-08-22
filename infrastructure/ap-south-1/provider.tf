terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"

    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
  # cloud {
  #   organization = "NiteshAutomates"
  #   workspaces {
  #     name = "ultimate-devops-infrastructure"
  #   }
  # }
}

provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAYYLNQXJ4SSCNZYD5"
  secret_key = "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"
}
