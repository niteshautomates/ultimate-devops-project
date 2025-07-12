resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.s3_bucket_name}-sensitive-data-${random_id.bucket_suffix.hex}"
  tags   = merge(var.tags, { Name = var.s3_bucket_name })
}


resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket_server_side_encryption_configuration" "name" {
  bucket = aws_s3_bucket.s3_bucket.bucket
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_master_key_arn
      sse_algorithm     = "aws:kms"
    }
  }
}


resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket_public_access_block" "s3_bucket_access_block" {
  bucket                  = aws_s3_bucket.s3_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "s3_bucket_polcy" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Sid = "DenyInsecureConnections"
            Effect = "Deny"
            Principal = "*"
            Action = "s3:*"
            Resource = [
                aws_s3_bucket.s3_bucket.arn,
                "${aws_s3_bucket.s3_bucket.arn}/*"
            ]

            Condition = {
                Bool = {
                    "aws:SecureTransport" = "False"
                }
            }
        }
    ]
  })
}