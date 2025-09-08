# AWS IAM Role Terraform Module

This Terraform module creates an AWS IAM role specifically designed for Amazon EKS (Elastic Kubernetes Service) with the necessary policies attached for cluster and worker node operations.

## Overview

The module creates an IAM role that can be assumed by EKS service principals (`eks.amazonaws.com` and `ec2.amazonaws.com`) and attaches the following AWS managed policies:

- **AmazonEKSClusterPolicy** - Required for EKS cluster operations
- **AmazonEKSWorkerNodePolicy** - Required for EKS worker node operations  
- **AmazonEKS_CNI_Policy** - Required for Container Network Interface (CNI) operations
- **AmazonEC2ContainerRegistryReadOnly** - Allows read-only access to ECR for pulling container images

## Architecture

```
Role/
├── main.tf                 # Main module configuration
├── variables.tf            # Input variables
├── provider.tf             # AWS provider configuration
├── backend.tf              # Terraform backend configuration
├── environments/
│   └── prod/
│       ├── prod.conf       # Environment configuration
│       └── prod.tfvars     # Production variable values
└── modules/
    └── role/
        ├── main.tf         # IAM role resource definitions
        └── variables.tf    # Module input variables
```

## Features

- **Cross-account access support** - Configured with role assumption for multi-account scenarios
- **Environment-specific configuration** - Separate configurations for different environments
- **Modular design** - Reusable role module with configurable parameters
- **Security best practices** - Uses least privilege principle with specific service principals

## Usage

### Basic Usage

```hcl
module "role" {
  source = "./modules/role"
  
  role_name = "my-eks-role"
  aws_iam_role_version = "2012-10-17"
  aws_iam_role_assume_action = "sts:AssumeRole"
  aws_iam_role_assume_effect = "Allow"
  aws_iam_role_service_principals = ["eks.amazonaws.com", "ec2.amazonaws.com"]
  aws_iam_role_policy_eks_policy = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  aws_iam_role_policy_node_policy = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  aws_iam_role_policy_cni_policy = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  aws_iam_role_policy_ec2_policy = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
```

### Using Environment Configuration

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

## Input Variables

### Main Module Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `region` | The AWS region where the role will be created | `string` | n/a | yes |
| `environment` | Environment name (e.g., dev, prod, staging) | `string` | n/a | yes |
| `use_name_prefix` | Use name prefix for security groups | `bool` | `false` | no |
| `role_arn` | Role ARN to assume for cross-account access | `string` | n/a | yes |
| `allowed_account_ids` | List of allowed account IDs for cross-account access | `list(string)` | n/a | yes |
| `role_name` | Name of the IAM role to create | `string` | n/a | yes |
| `aws_iam_role_version` | Version of the AWS IAM role policy | `string` | n/a | yes |
| `aws_iam_role_assume_action` | Action for the IAM role to assume | `string` | n/a | yes |
| `aws_iam_role_assume_effect` | Effect for the IAM role to assume | `string` | n/a | yes |
| `aws_iam_role_service_principals` | List of service principals for the IAM role | `list(string)` | n/a | yes |
| `aws_iam_role_policy_eks_policy` | ARN of the EKS policy to attach to the IAM role | `string` | n/a | yes |
| `aws_iam_role_policy_node_policy` | ARN of the EKS worker node policy to attach to the IAM role | `string` | n/a | yes |
| `aws_iam_role_policy_cni_policy` | ARN of the EKS CNI policy to attach to the IAM role | `string` | n/a | yes |
| `aws_iam_role_policy_ec2_policy` | ARN of the EC2 Container Registry ReadOnly policy to attach to the IAM role | `string` | n/a | yes |

## Resources Created

This module creates the following AWS resources:

- `aws_iam_role.eks_role` - The main IAM role for EKS
- `aws_iam_role_policy_attachment.eks_policy` - Attaches AmazonEKSClusterPolicy
- `aws_iam_role_policy_attachment.eks_node_policy` - Attaches AmazonEKSWorkerNodePolicy
- `aws_iam_role_policy_attachment.eks_cni_policy` - Attaches AmazonEKS_CNI_Policy
- `aws_iam_role_policy_attachment.eks_ec2_policy` - Attaches AmazonEC2ContainerRegistryReadOnly

## Outputs

The module outputs the following values:

- `role_arn` - The ARN of the created IAM role
- `role_name` - The name of the created IAM role

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform >= 1.0.0
- AWS Provider >= 5.0

## Security Considerations

- The role is configured with specific service principals (`eks.amazonaws.com` and `ec2.amazonaws.com`)
- Uses AWS managed policies to ensure compliance with AWS best practices
- Supports cross-account access with role assumption for secure multi-account deployments
- Follows the principle of least privilege by only attaching necessary policies

## Example Production Configuration

The `environments/prod/prod.tfvars` file contains a complete example configuration:

```hcl
region = "ap-southeast-1"
environment = "prod"
use_name_prefix = false

# Cross-account configuration
role_arn = "arn:aws:iam::86868686868:role/Admin"
allowed_account_ids = ["86868686868"]

# IAM Role Configuration
role_name = "eks-role"
aws_iam_role_version = "2012-10-17"
aws_iam_role_assume_action = "sts:AssumeRole"
aws_iam_role_assume_effect = "Allow"
aws_iam_role_service_principals = ["eks.amazonaws.com", "ec2.amazonaws.com"]
aws_iam_role_policy_eks_policy = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
aws_iam_role_policy_node_policy = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
aws_iam_role_policy_cni_policy = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
aws_iam_role_policy_ec2_policy = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
```

## Troubleshooting

### Common Issues

1. **Permission Denied**: Ensure the AWS credentials have sufficient permissions to create IAM roles and policies
2. **Cross-account Access**: Verify the `role_arn` and `allowed_account_ids` are correctly configured
3. **Service Principal Issues**: Ensure the service principals are correctly specified for your use case

### Validation

To validate the configuration:

```bash
terraform validate
terraform plan -var-file="environments/prod/prod.tfvars"
```

## Contributing

When modifying this module:

1. Update the variables documentation
2. Test with different environment configurations
3. Ensure backward compatibility
4. Update this README with any new features or changes

## License

This module is part of the terraform-main project. Please refer to the main project LICENSE file for licensing information.
