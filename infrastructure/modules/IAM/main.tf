resource "aws_iam_role" "iam_role" {
  name                  = var.role_name
  force_detach_policies = var.force_detach_policies
  assume_role_policy    = jsonencode(var.assume_role_policy) #jsonencode encodes a given value to a string using JSON syntax
  description           = var.description == "" ? var.role_name : var.description
  max_session_duration  = var.max_session_duration
  path                  = var.path
  tags                  = merge(var.tags, { Name = var.role_name })
}


resource "aws_iam_policy" "iam_policy" {
  count       = length(var.custom_iam_policies)
  name        = lookup(var.custom_iam_policies[count.index], "name", null)
  policy      = lookup(var.custom_iam_policies[count.index], "policy_document", null)
  description = lookup(var.custom_iam_policies[count.index], "description", format("Policy for %s", var.role_name))
  path        = lookup(var.custom_iam_policies[count.index], "path", var.path)
}


resource "aws_iam_policy_attachment" "custom_policy_attachment" {
  count      = length(var.custom_iam_policies)
  name       = "custom_attachment"
  roles      = [aws_iam_policy.iam_policy]
  policy_arn = aws_iam_policy.iam_policy.*.arn[count.index]
  depends_on = [aws_iam_policy.iam_policy]
}

resource "aws_iam_role_policy_attachment" "managed_policy_attachment" {
  count      = length(var.managed_iam_ploicies)
  role       = aws_iam_policy.iam_policy
  policy_arn = var.managed_iam_ploicies[count.index]
  depends_on = [aws_iam_policy.iam_policy]
}
