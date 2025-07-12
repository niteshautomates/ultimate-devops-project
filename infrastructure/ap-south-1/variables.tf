variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "tags" {
  type = map(string)
  default = {
    "Project" = "ultimate-devops-project"
    MangedBy  = "Terraform"
  }
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "project_name" {
  type    = string
  default = "ultimate-devops-project"
}

variable "key_name" {
  type = string
  default = "ssh_key_ap"
}
