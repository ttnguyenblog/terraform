# EKS Terraform Module

This Terraform module provisions a complete Amazon Elastic Kubernetes Service (EKS) cluster with all necessary components including VPC, IAM roles, node groups, and EKS addons.

## Architecture

The module creates the following AWS resources:

- **VPC**: Custom Virtual Private Cloud with public and private subnets across multiple availability zones
- **IAM Roles**: Service roles for EKS cluster and worker nodes with necessary policies
- **EKS Cluster**: Kubernetes cluster with configurable version and authentication
- **Node Group**: Managed worker nodes with auto-scaling capabilities
- **EKS Addons**: Essential Kubernetes addons (VPC CNI, kube-proxy, CoreDNS, metrics-server)
- **Access Management**: IAM access entries and policy associations for cluster access

## Module Structure

```
EKS/
├── main.tf                 # Main module configuration
├── variables.tf            # Input variables
├── provider.tf             # AWS provider configuration
├── backend.tf              # Terraform backend configuration
├── environments/
│   └── prod/
│       ├── prod.conf       # Environment configuration
│       └── prod.tfvars     # Production variable values
└── modules/
    ├── vpc/                # VPC module
    ├── role/               # IAM role module
    └── eks/                # EKS cluster module
```

## Prerequisites

- Terraform >= 1.0.0
- AWS CLI configured with appropriate credentials
- AWS account with EKS service permissions
- kubectl (for cluster interaction after deployment)

## Usage

### 1. Configure Backend (Optional)

Uncomment and configure the S3 backend in `backend.tf`:

```hcl
terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "eks/terraform.tfstate"
    region = "ap-southeast-1"
  }
}
```

### 2. Set Environment Variables

Copy the production environment configuration:

```bash
cp environments/prod/prod.tfvars environments/prod/my-environment.tfvars
```

Edit the variables file with your specific values.

### 3. Initialize and Deploy

```bash
# Initialize Terraform
terraform init

# Plan the deployment
mkdir prod
terraform plan -var-file="environments/prod/prod.tfvars" -no-color -out="prod/tf.plan"

# Apply the configuration
terraform apply prod/tf.plan

# Destroy

terraform destroy -var-file="environments/prod/prod.tfvars" -auto-approve
```

## Configuration

### Key Variables

#### VPC Configuration
- `vpc_cidr_block`: CIDR block for the VPC (default: "10.0.0.0/16")
- `public_subnets_cidr`: List of CIDR blocks for public subnets
- `private_subnets_cidr`: List of CIDR blocks for private subnets
- `region`: AWS region for deployment

#### EKS Configuration
- `eks_cluster_name`: Name of the EKS cluster
- `eks_version`: Kubernetes version for the cluster
- `eks_desired_size`: Desired number of worker nodes
- `eks_max_size`: Maximum number of worker nodes
- `eks_min_size`: Minimum number of worker nodes
- `eks_instance_type`: EC2 instance type for worker nodes

#### IAM Configuration
- `role_arn`: ARN of the IAM role to assume
- `allowed_account_ids`: List of allowed AWS account IDs
- `aws_iam_access_entry`: ARN of the IAM user/role for cluster access

#### EKS Addons
- `eks_addons`: List of EKS addons with name and version

### Example Configuration

```hcl
# VPC Configuration
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

# EKS Configuration
eks_cluster_name = "my-eks-cluster"
eks_version = "1.33"
eks_desired_size = 2
eks_max_size = 5
eks_min_size = 1
eks_instance_type = "t3.medium"

# EKS Addons
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
  }
]
```

## Outputs

The module provides the following outputs:

- `cluster_endpoint`: EKS cluster endpoint URL
- `cluster_name`: Name of the EKS cluster
- `cluster_security_group_id`: Security group ID of the EKS cluster
- `cluster_arn`: ARN of the EKS cluster
- `cluster_certificate_authority_data`: Base64 encoded certificate authority data
- `node_group_arn`: ARN of the EKS node group
- `vpc_id`: ID of the VPC
- `public_subnet_ids`: List of public subnet IDs
- `private_subnet_ids`: List of private subnet IDs

## Post-Deployment

### Configure kubectl

After successful deployment, configure kubectl to connect to your cluster:

```bash
aws eks update-kubeconfig --region ap-southeast-1 --name your-cluster-name
```

### Verify Cluster

```bash
# Check cluster status
kubectl get nodes

# Check system pods
kubectl get pods -n kube-system

# Check EKS addons
kubectl get pods -n kube-system | grep -E "(vpc-cni|kube-proxy|coredns|metrics-server)"
```

## Security Considerations

- The module creates IAM roles with minimal required permissions
- EKS cluster uses API_AND_CONFIG_MAP authentication mode
- Worker nodes are deployed in public subnets (consider private subnets for production)
- Access is controlled through IAM access entries and policy associations

## Cost Optimization

- Use appropriate instance types based on workload requirements
- Configure auto-scaling to match demand
- Consider using Spot instances for non-critical workloads
- Monitor cluster usage and adjust node group sizes accordingly

## Troubleshooting

### Common Issues

1. **Insufficient permissions**: Ensure the IAM role has all required EKS policies
2. **Subnet configuration**: Verify subnet CIDR blocks don't overlap
3. **EKS version compatibility**: Check addon versions are compatible with EKS version
4. **Resource limits**: Ensure AWS service limits are not exceeded

### Useful Commands

```bash
# Check Terraform state
terraform state list

# Import existing resources
terraform import aws_eks_cluster.aws_eks cluster-name

# Destroy resources
terraform destroy -var-file="environments/prod/prod.tfvars"
```

## Contributing

1. Follow Terraform best practices
2. Update documentation for any changes
3. Test changes in a development environment first
4. Ensure all variables are properly documented

## License

This module is part of the terraform-main project. Please refer to the main project LICENSE file for licensing information.