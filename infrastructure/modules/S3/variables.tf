variable "s3_bucket_name" {
  description = "Define S3 bucket name"
  default = "dummy"
}

variable "tags" {
  type = map(string)
}


variable "kms_master_key_arn" {
  type = string
}