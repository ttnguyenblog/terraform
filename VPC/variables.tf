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