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

variable "public_subnets_id" {
  type        = list(any)
  description = "CIDR block for Public Subnet"
}


variable "security_group_id" {
  description = "Security Group ID for the instances"
  type        = list(string)
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