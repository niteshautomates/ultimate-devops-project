output "role_name" {
  value = aws_iam_role.iam_role.name
  description = "IAM Role name"
}

output "iam_role_arn" {
  value = aws_iam_role.iam_role.arn
  description = "IAM Role ARN"
}

output "iam_role_id" {
  description = "IAM Role ID"
  value = aws_iam_role.iam_role.id
}

output "iam_policy_names" {
  description = "IAM Policy names"
  value = concat(aws_iam_policy.iam_policy.*.name,var.managed_iam_ploicies)
}

output "iam_policy_arns" {
  description = "IAM Policy ARN's"
  value = concat(aws_iam_policy.iam_policy.*.arn,var.managed_iam_ploicies)
}