variable "s3_bucket_name" {
  description = "Define S3 bucket name"
  default = "dummy"
}

variable "tags" {
  type = map(string)
}


variable "aws_kms_key_id" {
  type = string
}