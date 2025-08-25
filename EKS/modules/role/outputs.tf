output "aws_iam_eks_role_arn" {
  description = "ARN of the IAM role created for EKS"
  value       = aws_iam_role.eks_role.arn
}