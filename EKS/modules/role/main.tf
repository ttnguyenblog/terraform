resource "aws_iam_role" "eks_role" {
  name = var.role_name
  assume_role_policy = jsonencode({
    Version = var.aws_iam_role_version
    Statement = [
      {
        Action = var.aws_iam_role_assume_action
        Effect = var.aws_iam_role_assume_effect
        Principal = {
          Service = var.aws_iam_role_service_principals
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_policy" {
  for_each   = toset(var.aws_iam_role_policy_eks_policy)
  role       = aws_iam_role.eks_role.name
  policy_arn = each.value
}