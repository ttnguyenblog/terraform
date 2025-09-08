# VPC Terraform Module

This Terraform module creates a complete Virtual Private Cloud (VPC) infrastructure on AWS with public and private subnets across multiple availability zones.

## Overview

The VPC module provisions:
- A VPC with DNS hostnames and DNS support enabled
- Public subnets with internet gateway access
- Private subnets for internal resources
- Route tables and associations for proper traffic routing
- Internet Gateway for public subnet internet access

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        VPC (10.0.0.0/16)                    │
│                                                             │
│  ┌─────────────────┐  ┌─────────────────┐  ┌──────────────┐ │
│  │   Public AZ-a   │  │   Public AZ-b   │  │  Public AZ-c │ │
│  │  10.0.0.0/27    │  │  10.0.0.32/27   │  │ 10.0.0.64/27 │ │
│  │                 │  │                 │  │              │ │
│  └─────────────────┘  └─────────────────┘  └──────────────┘ │
│           │                     │                    │      │
│           └─────────────────────┼────────────────────┘      │
│                                 │                           │
│  ┌─────────────────┐  ┌─────────────────┐  ┌──────────────┐ │
│  │  Private AZ-a   │  │  Private AZ-b   │  │ Private AZ-c │ │
│  │ 10.0.0.96/27    │  │ 10.0.0.128/27   │  │10.0.0.160/27 │ │
│  │                 │  │                 │  │              │ │
│  └─────────────────┘  └─────────────────┘  └──────────────┘ │
│                                                             │
└─────────────────────────────────────────────────────────────┘
                                │
                        ┌───────▼───────┐
                        │ Internet      │
                        │ Gateway       │
                        └───────────────┘
```

## Features

- **Multi-AZ Deployment**: Automatically distributes subnets across 3 availability zones
- **DNS Support**: VPC configured with DNS hostnames and DNS support enabled
- **Public Subnets**: Auto-assign public IPs and direct internet access via Internet Gateway
- **Private Subnets**: Isolated subnets for internal resources without direct internet access
- **Route Tables**: Separate routing for public and private subnets
- **Cross-Account Support**: Configured for cross-account access with role assumption

## Usage

### Basic Usage

```hcl
module "vpc" {
  source = "./modules/vpc"
  
  vpc_cidr_block        = "10.0.0.0/16"
  public_subnets_cidr   = ["10.0.0.0/27", "10.0.0.32/27", "10.0.0.64/27"]
  private_subnets_cidr  = ["10.0.0.96/27", "10.0.0.128/27", "10.0.0.160/27"]
  region                = "ap-southeast-1"
}
```

### Using with Production Configuration

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

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `vpc_cidr_block` | CIDR block for the VPC | `string` | n/a | yes |
| `public_subnets_cidr` | List of CIDR blocks for public subnets | `list(any)` | n/a | yes |
| `private_subnets_cidr` | List of CIDR blocks for private subnets | `list(any)` | n/a | yes |
| `region` | AWS region where resources will be created | `string` | n/a | yes |
| `environment` | Environment name (e.g., dev, prod, staging) | `string` | n/a | yes |
| `role_arn` | Role ARN to assume for cross-account access | `string` | n/a | yes |
| `allowed_account_ids` | List of allowed account IDs for cross-account access | `list(string)` | n/a | yes |
| `use_name_prefix` | Use name prefix for security groups | `bool` | `false` | no |

## Outputs

The module provides the following outputs:

- `vpc_id` - ID of the VPC
- `vpc_cidr_block` - CIDR block of the VPC
- `public_subnet_ids` - List of IDs of the public subnets
- `private_subnet_ids` - List of IDs of the private subnets
- `internet_gateway_id` - ID of the Internet Gateway
- `public_route_table_id` - ID of the public route table
- `private_route_table_id` - ID of the private route table

## Resources Created

| Resource Type | Resource Name | Description |
|---------------|---------------|-------------|
| `aws_vpc` | vpc | Main VPC with DNS support |
| `aws_subnet` | public_subnets | Public subnets across AZs |
| `aws_subnet` | private_subnets | Private subnets across AZs |
| `aws_internet_gateway` | igw | Internet Gateway for public access |
| `aws_route_table` | public_route_table | Route table for public subnets |
| `aws_route_table` | private_route_table | Route table for private subnets |
| `aws_route` | public_internet_gateway | Route to Internet Gateway |
| `aws_route_table_association` | public_subnet_association | Associate public subnets with route table |
| `aws_route_table_association` | private_subnet_association | Associate private subnets with route table |

## Configuration Examples

### Production Configuration (prod.tfvars)

```hcl
region = "ap-southeast-1"
environment = "prod"
use_name_prefix = false

role_arn = "arn:aws:iam::8686868686868:role/admin"
allowed_account_ids = ["8686868686868"]

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
```

## Prerequisites

- Terraform >= 1.0.0
- AWS Provider ~> 5.0
- Valid AWS credentials or role assumption configured
- Appropriate IAM permissions for VPC, subnet, and route table creation

## Security Considerations

- Private subnets have no direct internet access
- Public subnets are configured with auto-assign public IPs
- Cross-account access is configured via role assumption
- DNS hostnames and support are enabled for better service discovery

## Cost Optimization

- Uses /27 subnets (32 IPs each) to minimize IP waste
- No NAT Gateway configured (can be added separately if needed)
- Resources are tagged appropriately for cost tracking

## Troubleshooting

### Common Issues

1. **Insufficient IP addresses**: Ensure your CIDR blocks don't overlap and provide enough IPs
2. **Cross-account access**: Verify the role ARN and account IDs are correct
3. **Region availability**: Ensure the specified region supports all required services

### Useful Commands

```bash
# Validate configuration
terraform validate

# Format code
terraform fmt

# Show current state
terraform show

# List resources
terraform state list
```

## Contributing

When modifying this module:

1. Update the version constraints in `backend.tf`
2. Test changes in a development environment first
3. Update this README if new variables or outputs are added
4. Ensure all resources are properly tagged

## License

This module is part of the terraform-main project. Please refer to the main project LICENSE file for licensing information.
