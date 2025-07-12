variable "name" {
  type = string
  description = "EC2 server name"
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

