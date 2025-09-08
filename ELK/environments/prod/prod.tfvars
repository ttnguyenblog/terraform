### Region and Environment Configuration
region = "ap-southeast-1"

environment = "prod"

use_name_prefix = false

### Role_arn and allowed_account_ids Configuration
role_arn            = "arn:aws:iam::891612588944:role/admin"
allowed_account_ids = ["891612588944"]

### VPC CIDR Block Configuration
vpc_cidr_block = "10.0.0.0/16"

public_subnets_cidr = [
  "10.0.0.0/27",
  "10.0.0.32/27",
  "10.0.0.64/27"
]

private_subnets_cidr = [
  "10.0.0.96/27",
  "10.0.0.128/27",
  "10.0.0.160/27"
]

### Security Group Configuration
name_sg        = "ec2-sg"
description_sg = "Security Group for EC2 instances"

webapp_cidr_rules = [
  ["0.0.0.0/0", "0-65535", "tcp", "Allow all TCP"],
]

default_egress_rule_from_port   = 0
default_egress_rule_to_port     = 0
default_egress_rule_protocol    = "-1"
default_egress_rule_cidr_blocks = "0.0.0.0/0"

### EC2 Instance Configuration

create_webapp         = true
webapp_instance_types = ["t2.micro"]
ami_id                = "ami-0933f1385008d33c4"
instance_name         = "elk-instance"

key_name = "my-ec2-key"
path_to_public_key = "./keys/my-ec2-key.pub"
path_to_private_key = "./keys/my-ec2-key.pem"
