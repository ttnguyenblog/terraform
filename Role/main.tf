module "role" {
  source = "./modules/role"
  role_name = var.role_name
  aws_iam_role_version = var.aws_iam_role_version
  aws_iam_role_assume_action = var.aws_iam_role_assume_action
  aws_iam_role_assume_effect = var.aws_iam_role_assume_effect
  aws_iam_role_service_principals = var.aws_iam_role_service_principals
  aws_iam_role_policy_eks_policy = var.aws_iam_role_policy_eks_policy
  aws_iam_role_policy_node_policy = var.aws_iam_role_policy_node_policy
  aws_iam_role_policy_cni_policy = var.aws_iam_role_policy_cni_policy
  aws_iam_role_policy_ec2_policy = var.aws_iam_role_policy_ec2_policy  
}
