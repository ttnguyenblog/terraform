## RDS Subnet Group Name
variable "rds_subnet_group_name" {
  description = "The name of the RDS subnet group"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(any)
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

variable "rds_security_group_id" {
  description = "The security group ID to associate with the RDS instance"
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
