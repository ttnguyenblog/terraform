### Region and Environment Configuration
region = "ap-southeast-1"

environment = "prod"

use_name_prefix = false

### Role_arn and allowed_account_ids Configuration
role_arn            = "arn:aws:iam::86868686868:role/Admin"
allowed_account_ids = ["86868686868"]

#IAM Role Configuration
role_name = "eks-role"
aws_iam_role_version = "2012-10-17"
aws_iam_role_assume_action = "sts:AssumeRole"
aws_iam_role_assume_effect = "Allow"
aws_iam_role_service_principals = ["eks.amazonaws.com", "ec2.amazonaws.com"]
aws_iam_role_policy_eks_policy = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
aws_iam_role_policy_node_policy = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
aws_iam_role_policy_cni_policy = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
aws_iam_role_policy_ec2_policy = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"