## Variable Provider
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

##VPC
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

variable "webapp_sg_name" {
  description = "Name of the Security Group"
  type        = string
}

variable "description_webapp_sg" {
  description = "Description of the Security Group"
  type        = string
  default     = "Security Group managed by Terraform"
}


variable "rds_sg_name" {
  description = "Name of the Security Group"
  type        = string
}

variable "description_rds_sg" {
  description = "Description of the Security Group"
  type        = string
  default     = "Security Group managed by Terraform"
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

## RDS Instance Configuration

variable "rds_instance_identifier" {
  description = "The identifier for the RDS instance"
  type        = string
}

variable "rds_allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
}

variable "rds_engine" {
  description = "The database engine to use (e.g., mysql, postgres)"
  type        = string
}

variable "rds_engine_version" {
  description = "The version of the database engine"
  type        = string
}

variable "rds_instance_class" {
  description = "The instance class to use for the RDS instance"
  type        = string
}

variable "rds_username" {
  description = "The master username for the RDS instance"
  type        = string
  
}

variable "rds_password" {
  description = "The master password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "rds_parameter_group_name" {
  description = "The name of the DB parameter group to associate"
  type        = string
}

variable "rds_multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
}

variable "rds_backup_retention_period" {
  description = "The days to retain backups for the RDS instance"
  type        = number
}

variable "rds_storage_type" {
  description = "The storage type to use (e.g., gp2, io1)"
  type        = string
}

variable "rds_skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
  type        = bool
}

variable "rds_pulicly_accessible" {
  description = "Specifies whether the RDS instance is publicly accessible"
  type        = bool
}

variable "rds_storage_encrypted" {
  description = "Specifies whether the RDS instance is encrypted"
  type        = bool
}


## RDS Subnet Group Name
variable "rds_subnet_group_name" {
  description = "The name of the RDS subnet group"
  type        = string
}

## EC2 Instance Configuration

##Key Pair Variables
variable "key_name" {
  description = "Name of key"
  type        = string
}

variable "path_to_public_key" {
  description = "Path to public key"
  type = string
}

## Instance Variables

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

