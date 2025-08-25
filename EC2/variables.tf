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

### Security Group
variable "name_sg" {
  description = "Name of the Security Group"
  type        = string
}

variable "description_sg" {
  description = "Description of the Security Group"
  type        = string
  default     = "Security Group managed by Terraform"
}

variable "webapp_cidr_rules" {
  description = "List of WebApp ingress rules with CIDR blocks in format [cidr_block, port_or_range, protocol, description]"
  type        = list(list(string))
  default     = []
}

# Egress rule configuration
variable "default_egress_rule_from_port" {
  description = "From port for default egress rule"
  type        = number
  default     = 0
}

variable "default_egress_rule_to_port" {
  description = "To port for default egress rule"
  type        = number
  default     = 0
}

variable "default_egress_rule_protocol" {
  description = "Protocol for default egress rule"
  type        = string
  default     = "-1"
}

variable "default_egress_rule_cidr_blocks" {
  description = "CIDR blocks for default egress rule"
  type        = string
  default     = "0.0.0.0/0"
}

### EC2 Instance

variable "create_webapp" {
  type    = bool
  default = true
}

variable "webapp_instance_types" {
  description = "List of instance types for webapp instances"
  type        = list(string)
}

variable "instance_name" {
  description = "Name tag for the instances"
  type        = string
  
}

variable "ami_id" {
  description = "AMI ID for the instances"
  type        = string
}

variable "key_name" {
  description = "Name of key"
  type        = string
}

variable "path_to_public_key" {
  description = "Path to public key"
  type = string
}

variable "path_to_private_key" {
  description = "Path to private key"
  type = string
}