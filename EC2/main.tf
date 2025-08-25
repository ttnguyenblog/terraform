module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr_block       = var.vpc_cidr_block
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  region               = var.region
}

module "sg" {
  source            = "./modules/sg"
  name_sg           = var.name_sg
  vpc_id            = module.vpc.vpc_id
  description_sg    = var.description_sg
  webapp_cidr_rules = var.webapp_cidr_rules
}

module "instance" {
  source                = "./modules/instance"
  create_webapp         = var.create_webapp
  webapp_instance_types = var.webapp_instance_types
  ami_id                = var.ami_id
  public_subnets_id     = module.vpc.public_subnets_id
  security_group_id     = [module.sg.security_group_id]
  instance_name         = var.instance_name
  key_name              = var.key_name
  path_to_public_key    = var.path_to_public_key
  path_to_private_key   = var.path_to_private_key
  depends_on            = [module.vpc, module.sg]
}
