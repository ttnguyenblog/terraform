### Region and Environment Configuration
region          = "ap-southeast-1"
environment     = "prod"
use_name_prefix = false

### Role_arn and allowed_account_ids Configuration
role_arn            = "arn:aws:iam::868686886868686:role/Admin"
allowed_account_ids = ["868686886868686"]

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

#IAM Role Configuration
role_name                  = "eks-role"
aws_iam_role_version       = "2012-10-17"
aws_iam_role_assume_action = "sts:AssumeRole"
aws_iam_role_assume_effect = "Allow"
aws_iam_role_service_principals = [
  "eks.amazonaws.com",
  "ec2.amazonaws.com"
]
aws_iam_role_policy_eks_policy = [
  "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
  "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
  "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
  "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
  "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
]


# EKS Cluster Configuration
eks_cluster_name        = "eks-cluster"
aws_eks_node_group_name = "eks-node-group"

eks_version       = "1.33"
eks_desired_size  = 1
eks_max_size      = 1
eks_min_size      = 1
eks_instance_type = "t2.large"

# IAM Access Entry Configuration
aws_iam_access_entry    = "arn:aws:iam::868686868686:user/eks"
type                    = "STANDARD"
eks_authentication_mode = "API_AND_CONFIG_MAP"

#Policy Access Configuration
access_policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
access_scope_type = "cluster"
eks_addons = [
  {
    name    = "vpc-cni"
    version = "v1.19.5-eksbuild.1"
  },
  {
    name    = "kube-proxy"
    version = "v1.33.0-eksbuild.2"
  },
  {
    name    = "coredns"
    version = "v1.12.1-eksbuild.2"
  },
  {
    name    = "metrics-server"
    version = "v0.8.0-eksbuild.1"
  }
]


