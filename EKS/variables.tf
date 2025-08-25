# Variable Provider

variable "region" {
  description = "The AWS region where the VPC will be created."
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, prod, staging)"
  type        = string
}

variable "use_name_prefix" {
  description = "Use name prefix for security groups"
  type        = bool
  default     = false
}

variable "role_arn" {
  description = "Role ARN to assume for cross-account access"
  type        = string
}

variable "allowed_account_ids" {
  description = "List of allowed account IDs for cross-account access"
  type        = list(string)
}

#VPC
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Public Subnet"
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Private Subnet"
}

#Role

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


# EKS
variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "aws_eks_node_group_name" {
  description = "Name of the EKS node group"
  type        = string
  
}

variable "eks_version" {
  description = "Version of the EKS cluster"
  type        = string
}

variable "eks_desired_size" {
  description = "Desired size of the EKS node group"
  type        = number
}

variable "eks_max_size" {
  description = "Maximum size of the EKS node group"
  type        = number
}

variable "eks_min_size" {
  description = "Minimum size of the EKS node group"
  type        = number
  
}

variable "eks_instance_type" {
  description = "Instance type for the EKS worker nodes"
  type        = string  
}


variable "aws_iam_access_entry" {
  description = "Name of the EKS cluster for IAM access entry"
  type        = string
  
}

variable "eks_authentication_mode" {
  description = "Authentication mode for EKS access"
  type        = string  
  
}

variable "type" {
  description = "Type of IAM access entry"
  type        = string 
}

variable "access_policy_arn" {
  description = "ARN of the access policy"
  type        = string
}

variable "access_scope_type" {
  description = "Type of access scope"
  type        = string
}

variable "eks_addons" {
  type = list(object({
    name    = string
    version = string
  }))
}
