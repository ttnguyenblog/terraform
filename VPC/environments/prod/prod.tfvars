### Region and Environment Configuration
region = "ap-southeast-1"

environment = "prod"

use_name_prefix = false

### Role_arn and allowed_account_ids Configuration
role_arn            = "arn:aws:iam::8686868686868:role/admin"
allowed_account_ids = ["8686868686868"]

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
