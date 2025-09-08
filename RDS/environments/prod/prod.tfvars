### Region and Environment Configuration
region = "ap-southeast-1"

environment = "prod"

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

## Security Group Configuration

### Security Group Configuration for Web Application
webapp_sg_name        = "ec2-sg"
description_webapp_sg = "Security Group for EC2 instances"

webapp_cidr_rules = [
  ["0.0.0.0/0", "80", "tcp", "Allow HTTP"],
  ["0.0.0.0/0", "443", "tcp", "Allow HTTPS"],
  ["0.0.0.0/0", "22", "tcp", "Allow SSH"],
  ["0.0.0.0/0", "5000", "tcp", "Allow App Port"]
]

### Security Group Configuration for Database
rds_sg_name        = "rds-sg"
description_rds_sg = "Security Group for RDS"

rds_sg_rules = [
  ["webapp", "3306", "tcp", "Allow MySQL from WebApp"],
]

### Default Egress Rule Configuration
default_egress_rule_protocol    = "-1"
default_egress_rule_cidr_blocks = "0.0.0.0/0"

### RDS Configuration
rds_subnet_group_name   = "rds-subnet-group"

rds_instance_identifier = "my-rds-instance"

rds_allocated_storage   = 20
rds_storage_type       = "gp2"

rds_engine         = "mysql"
rds_engine_version = "8.0"
rds_instance_class = "db.t3.micro"

rds_username = "admin"
rds_password = "Admin1234567890"

rds_parameter_group_name = "default.mysql8.0"
rds_skip_final_snapshot  = true
rds_multi_az             = false
rds_pulicly_accessible   = false
rds_storage_encrypted    = true
rds_backup_retention_period = 0


### EC2 Instance Configuration

create_webapp         = true
webapp_instance_types = ["t2.medium"]
ami_id                = "ami-0933f1385008d33c4"
instance_name         = "webapp-instance"

key_name = "my-ec2-key"
path_to_public_key = "./keys/my-ec2-key.pub"

