##VPC
module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr_block       = var.vpc_cidr_block
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  region               = var.region
}

##Security Groups
module "sg" {
  source = "./modules/sg"

  ### Security Group for Web Application
  webapp_sg_name        = var.webapp_sg_name
  vpc_id                = module.vpc.vpc_id
  description_webapp_sg = var.description_webapp_sg

  webapp_cidr_rules = var.webapp_cidr_rules


  ### Security Group for Database
  rds_sg_name        = var.rds_sg_name
  description_rds_sg = var.description_rds_sg

  rds_sg_rules = var.rds_sg_rules

  default_egress_rule_from_port   = var.default_egress_rule_from_port
  default_egress_rule_to_port     = var.default_egress_rule_to_port
  default_egress_rule_protocol    = var.default_egress_rule_protocol
  default_egress_rule_cidr_blocks = var.default_egress_rule_cidr_blocks

}

##RDS
module "rds" {
  source = "./modules/rds"

  ### Subnet Group Configuration

  rds_subnet_group_name = var.rds_subnet_group_name
  private_subnet_ids    = module.vpc.private_subnets_ids

  rds_instance_identifier = var.rds_instance_identifier

  rds_allocated_storage = var.rds_allocated_storage
  rds_storage_type      = var.rds_storage_type

  rds_engine         = var.rds_engine
  rds_engine_version = var.rds_engine_version
  rds_instance_class = var.rds_instance_class

  rds_username = var.rds_username
  rds_password = var.rds_password

  rds_parameter_group_name = var.rds_parameter_group_name
  rds_skip_final_snapshot  = var.rds_skip_final_snapshot

  rds_security_group_id = module.sg.security_group_id_rds

  rds_multi_az                = var.rds_multi_az
  rds_pulicly_accessible      = var.rds_pulicly_accessible
  rds_storage_encrypted       = var.rds_storage_encrypted
  rds_backup_retention_period = var.rds_backup_retention_period

}


module "instance" {
  source                = "./modules/instance"
  create_webapp         = var.create_webapp
  webapp_instance_types = var.webapp_instance_types
  ami_id                = var.ami_id
  public_subnets_ids    = module.vpc.public_subnets_ids
  security_group_id     = [module.sg.security_group_id_webapp]
  instance_name         = var.instance_name
  key_name              = var.key_name
  path_to_public_key    = var.path_to_public_key
  depends_on            = [module.vpc, module.sg, module.rds]
}
