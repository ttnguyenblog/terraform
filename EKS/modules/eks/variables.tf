variable "aws_iam_eks_role_arn" {
  description = "ARN of the IAM role for EKS"
  type        = string
}

variable "public_subnets_id" {
  type        = list(any)
  description = "CIDR block for Public Subnet"
}

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


variable "resolve_conflicts" {
  description = "resolve conflicts for eks addons"
  type        = string
  default     = "OVERWRITE"
  
}

