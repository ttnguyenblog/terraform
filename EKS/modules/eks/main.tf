# EKS Cluster and Node Group Configuration
resource "aws_eks_cluster" "aws_eks" {
  name     = var.eks_cluster_name
  role_arn = var.aws_iam_eks_role_arn
  version  = var.eks_version
  vpc_config {
    subnet_ids = var.public_subnets_id
  }

  access_config {
    authentication_mode = var.eks_authentication_mode
  }

  #Custom service CIDR block
  kubernetes_network_config {
    service_ipv4_cidr = "10.100.0.0/16" 
  }
}

resource "aws_eks_node_group" "aws_eks_worker_nodes" {
  cluster_name    = aws_eks_cluster.aws_eks.name
  node_group_name = var.aws_eks_node_group_name
  node_role_arn   = var.aws_iam_eks_role_arn
  subnet_ids      = var.public_subnets_id

  scaling_config {
    desired_size = var.eks_desired_size
    max_size     = var.eks_max_size
    min_size     = var.eks_min_size
  }

  instance_types = [var.eks_instance_type]
}

# IAM Role for EKS Access
resource "aws_eks_access_entry" "iam_access_entry" {
  cluster_name  = aws_eks_cluster.aws_eks.name
  principal_arn = var.aws_iam_access_entry
  type = var.type
}

resource "aws_eks_access_policy_association" "eks_admin_policy" {
  cluster_name  = aws_eks_cluster.aws_eks.name
  policy_arn    = var.access_policy_arn
  principal_arn = var.aws_iam_access_entry

  access_scope {
    type = var.access_scope_type
  }
}

resource "aws_eks_addon" "addons" {
  for_each                    = { for addon in var.eks_addons : addon.name => addon }
  cluster_name                = aws_eks_cluster.aws_eks.name
  addon_name                  = each.value.name
  addon_version               = each.value.version
  resolve_conflicts_on_create = var.resolve_conflicts
  resolve_conflicts_on_update = var.resolve_conflicts
}
