variable "role_name" {
  description = "Name of the IAM role to create"
  type        = string
  
}

variable "aws_iam_role_version" {
  description = "Version of the AWS IAM role policy"
  type        = string
}

variable "aws_iam_role_assume_action" {
    description = "Action for the IAM role to assume"
    type        = string
}

variable "aws_iam_role_assume_effect" {
    description = "Effect for the IAM role to assume"
    type        = string
}

variable "aws_iam_role_service_principals" {
  description = "List of service principals for the IAM role"
  type        = list(string)
}

variable "aws_iam_role_policy_eks_policy" {
  description = "ARN of the EKS policy to attach to the IAM role"
  type        = list(string)
}


