module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr_block       = var.vpc_cidr_block
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  region               = var.region
}

module "role" {
  source                                 = "./modules/role"
  role_name                              = var.role_name
  aws_iam_role_version                   = var.aws_iam_role_version
  aws_iam_role_assume_action             = var.aws_iam_role_assume_action
  aws_iam_role_assume_effect             = var.aws_iam_role_assume_effect
  aws_iam_role_service_principals        = var.aws_iam_role_service_principals
  aws_iam_role_policy_eks_policy         = var.aws_iam_role_policy_eks_policy
}

module "eks" {
  source                  = "./modules/eks"
  public_subnets_id       = module.vpc.public_subnets_id
  aws_eks_node_group_name = var.aws_eks_node_group_name
  aws_iam_eks_role_arn    = module.role.aws_iam_eks_role_arn
  eks_cluster_name        = var.eks_cluster_name
  eks_version             = var.eks_version
  eks_desired_size        = var.eks_desired_size
  eks_max_size            = var.eks_max_size
  eks_min_size            = var.eks_min_size
  eks_instance_type       = var.eks_instance_type
  aws_iam_access_entry    = var.aws_iam_access_entry
  eks_authentication_mode = var.eks_authentication_mode
  type                    = var.type

  access_policy_arn = var.access_policy_arn
  access_scope_type = var.access_scope_type
  eks_addons        = var.eks_addons

  depends_on = [
    module.role,
    module.vpc
  ]
}



