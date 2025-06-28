resource "aws_kms_key" "kms_key" {
  description             = "KMS Key for Ultimate DevOps Project Encryption"
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = true

  tags = merge(var.tags, { Name = "${var.project_name}-kms-key" })
}


resource "aws_kms_alias" "kms_alias" {
  name          = "alias/${var.project_name}-key"
  target_key_id = aws_kms_key.kms_key.id
}
