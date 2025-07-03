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
variable "AWS_ACCESS_KEY" {
  type = string

}
variable "AWS_SECRET_KEY" {
  type = string
}