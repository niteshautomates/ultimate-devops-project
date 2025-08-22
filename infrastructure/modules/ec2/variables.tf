variable "name" {
  type = string
  description = "EC2 server name"
  default = "bastian-server"
}

variable "instance_type" {
  type = string
  description = "ec2 instance type"
  default = "t2.small"
}

variable "key_name" {
  description = ".pem key file name to ssh into bastion server"
  type = string
  default = "ssh_key_ap"
}

variable "vpc_security_group_id" {
  description = "VPC security group ID"
  type        = string
  
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
  
}