### WebApp Security Group Configuration
variable "webapp_cidr_rules" {
  description = "List of WebApp ingress rules with CIDR blocks in format [cidr_block, port_or_range, protocol, description]"
  type        = list(list(string))
  default     = []
}

variable "webapp_sg_rules" {
  description = "List of WebApp ingress rules with source SGs in format [source_sg, port_or_range, protocol, description]. Source SG can be 'alb', 'db', 'webapp' or a specific SG ID."
  type        = list(list(string))
  default     = []
}

variable "webapp_sg_name" {
  description = "Name of the Security Group"
  type        = string
}

variable "description_webapp_sg" {
  description = "Description of the Security Group"
  type        = string
  default     = "Security Group managed by Terraform"
}

variable "vpc_id" {
  description = "VPC ID where the Security Group will be created"
  type        = string
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

### RDS Security Group Configuration

variable "rds_sg_name" {
  description = "Name of the Security Group"
  type        = string
}

variable "description_rds_sg" {
  description = "Description of the Security Group"
  type        = string
  default     = "Security Group managed by Terraform"
}

variable "rds_cidr_rules" {
  description = "List of WebApp ingress rules with CIDR blocks in format [cidr_block, port_or_range, protocol, description]"
  type        = list(list(string))
  default     = []
}

variable "rds_sg_rules" {
  description = "List of WebApp ingress rules with source SGs in format [source_sg, port_or_range, protocol, description]. Source SG can be 'alb', 'db', 'webapp' or a specific SG ID."
  type        = list(list(string))
  default     = []
}