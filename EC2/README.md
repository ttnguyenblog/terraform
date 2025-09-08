# EC2 Infrastructure with Terraform

This Terraform module provisions a complete EC2 infrastructure on AWS, including VPC, security groups, and EC2 instances with automatic Nginx installation.

## Architecture Overview

The module creates the following AWS resources:

- **VPC**: Virtual Private Cloud with DNS support
- **Subnets**: Public and private subnets across multiple availability zones
- **Internet Gateway**: For public subnet internet access
- **Route Tables**: Separate routing for public and private subnets
- **Security Groups**: Configurable security rules for EC2 instances
- **EC2 Instances**: Web application instances with automatic Nginx installation
- **Key Pairs**: SSH key management for instance access

## Directory Structure

```
EC2/
├── main.tf                    # Main Terraform configuration
├── variables.tf               # Variable definitions
├── provider.tf                # AWS provider configuration
├── backend.tf                 # Backend configuration (S3)
├── installNginx.sh            # Nginx installation script
├── environments/
│   └── prod/
│       ├── prod.conf          # Environment configuration
│       └── prod.tfvars        # Production variable values
├── keys/
│   └── my-ec2-key.pub         # SSH public key
└── modules/
    ├── vpc/                   # VPC module
    ├── sg/                    # Security Group module
    └── instance/              # EC2 Instance module
```

## Prerequisites

1. **AWS CLI** configured with appropriate credentials
2. **Terraform** >= 1.0.0 installed
3. **SSH Key Pair** generated and stored in the `keys/` directory
4. **AWS Account** with necessary permissions for:
   - VPC creation and management
   - EC2 instance creation
   - Security group management
   - IAM role assumption (if using cross-account access)

## Quick Start

### 1. Configure Variables

Copy and modify the production variables:

```bash
cp environments/prod/prod.tfvars environments/prod/my-environment.tfvars
```

Edit the variables according to your requirements:

```hcl
# Region and Environment
region = "us-west-2"
environment = "dev"

# VPC Configuration
vpc_cidr_block = "10.0.0.0/16"
public_subnets_cidr = ["10.0.0.0/27", "10.0.0.32/27", "10.0.0.64/27"]
private_subnets_cidr = ["10.0.0.96/27", "10.0.0.128/27", "10.0.0.160/27"]

# Security Group
name_sg = "my-ec2-sg"
webapp_cidr_rules = [
  ["0.0.0.0/0", "22", "tcp", "SSH access"],
  ["0.0.0.0/0", "80", "tcp", "HTTP access"],
  ["0.0.0.0/0", "443", "tcp", "HTTPS access"]
]

# EC2 Instances
create_webapp = true
webapp_instance_types = ["t2.micro", "t2.small"]
ami_id = "ami-0abcdef1234567890"  # Replace with your desired AMI
instance_name = "webapp-instance"
```

### 2. Prepare SSH Keys

Ensure your SSH key pair is in the `keys/` directory:

```bash
# Your public key should be named: my-ec2-key.pub
# Your private key should be named: my-ec2-key.pem
```

### 3. Initialize and Deploy

```bash
# Initialize Terraform
terraform init

# Plan the deployment
mkdir prod
terraform plan -var-file="environments/prod/prod.tfvars" -no-color -out="prod/tf.plan"

# Apply the configuration
terraform apply prod/tf.plan
```

## Configuration Options

### VPC Configuration

| Variable | Description | Default | Example |
|----------|-------------|---------|---------|
| `vpc_cidr_block` | CIDR block for the VPC | Required | `"10.0.0.0/16"` |
| `public_subnets_cidr` | List of public subnet CIDR blocks | Required | `["10.0.0.0/27", "10.0.0.32/27"]` |
| `private_subnets_cidr` | List of private subnet CIDR blocks | Required | `["10.0.0.96/27", "10.0.0.128/27"]` |

### Security Group Configuration

| Variable | Description | Default | Example |
|----------|-------------|---------|---------|
| `name_sg` | Name of the security group | Required | `"webapp-sg"` |
| `description_sg` | Description of the security group | `"Security Group managed by Terraform"` | `"Web application security group"` |
| `webapp_cidr_rules` | List of ingress rules | `[]` | `[["0.0.0.0/0", "80", "tcp", "HTTP"]]` |

### EC2 Instance Configuration

| Variable | Description | Default | Example |
|----------|-------------|---------|---------|
| `create_webapp` | Whether to create webapp instances | `true` | `true` |
| `webapp_instance_types` | List of instance types | Required | `["t2.micro", "t2.small"]` |
| `ami_id` | AMI ID for instances | Required | `"ami-0abcdef1234567890"` |
| `instance_name` | Name prefix for instances | Required | `"webapp-instance"` |
| `key_name` | Name of the SSH key pair | Required | `"my-ec2-key"` |

### Cross-Account Access (Optional)

| Variable | Description | Default | Example |
|----------|-------------|---------|---------|
| `role_arn` | IAM role ARN for cross-account access | Required | `"arn:aws:iam::123456789012:role/Admin"` |
| `allowed_account_ids` | List of allowed AWS account IDs | Required | `["123456789012"]` |

## Security Group Rules Format

The `webapp_cidr_rules` variable accepts a list of rules in the following format:

```hcl
webapp_cidr_rules = [
  [cidr_block, port_or_range, protocol, description]
]
```

Examples:

```hcl
webapp_cidr_rules = [
  ["0.0.0.0/0", "22", "tcp", "SSH access"],
  ["0.0.0.0/0", "80", "tcp", "HTTP access"],
  ["0.0.0.0/0", "443", "tcp", "HTTPS access"],
  ["10.0.0.0/16", "3306", "tcp", "MySQL from VPC"],
  ["0.0.0.0/0", "8080-8090", "tcp", "Custom application ports"]
]
```

## Automatic Nginx Installation

The module automatically installs and configures Nginx on all EC2 instances using the `installNginx.sh` script. The script:

1. Waits for the instance to be fully booted
2. Updates the package manager
3. Installs Nginx
4. Starts the Nginx service

## Outputs

The module provides the following outputs:

- `vpc_id`: ID of the created VPC
- `public_subnets_id`: List of public subnet IDs
- `private_subnets_id`: List of private subnet IDs
- `security_group_id`: ID of the created security group
- `instance_ids`: List of created EC2 instance IDs
- `instance_public_ips`: List of public IP addresses of instances

## Accessing Instances

After deployment, you can access your instances via SSH:

```bash
ssh -i keys/my-ec2-key.pem ubuntu@<instance-public-ip>
```

The Nginx web server will be running on port 80. You can access it via:

```bash
curl http://<instance-public-ip>
```

## Backend Configuration

The module is configured to use S3 as the backend for state storage. Uncomment and configure the backend block in `backend.tf`:

```hcl
terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "ec2/terraform.tfstate"
    region = "us-west-2"
  }
}
```

## Environment Management

The module supports multiple environments through the `environments/` directory structure:

- `environments/prod/`: Production environment configuration
- `environments/dev/`: Development environment configuration (create as needed)
- `environments/staging/`: Staging environment configuration (create as needed)

## Troubleshooting

### Common Issues

1. **SSH Key Not Found**: Ensure your SSH key pair exists in the `keys/` directory
2. **AMI Not Found**: Verify the AMI ID is valid for your region
3. **Insufficient Permissions**: Check your AWS credentials and IAM permissions
4. **Subnet CIDR Conflicts**: Ensure subnet CIDR blocks don't overlap

### Debugging

Enable Terraform debug logging:

```bash
export TF_LOG=DEBUG
terraform apply
```

### State Management

If you encounter state issues:

```bash
# Refresh state
terraform refresh

# Import existing resources (if needed)
terraform import aws_instance.example i-1234567890abcdef0
```

## Cost Optimization

- Use `t2.micro` instances for development/testing
- Consider using Spot instances for non-critical workloads
- Implement proper tagging for cost allocation
- Use private subnets for database instances

---
