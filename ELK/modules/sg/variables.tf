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

variable "name_sg" {
  description = "Name of the Security Group"
  type        = string
}

variable "description_sg" {
  description = "Description of the Security Group"
  type        = string
  default     = "Security Group managed by Terraform"
}

variable "vpc_id" {
  description = "VPC ID where the Security Group will be created"
  type        = string
}
