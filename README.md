# Terraform Main - AWS Infrastructure as Code

A comprehensive collection of Terraform modules for deploying various AWS infrastructure components. This repository provides modular, reusable infrastructure code for common AWS services including VPC, EC2, EKS, RDS, and IAM roles.

## 🏗️ Architecture Overview

This repository contains five main infrastructure modules:

- **VPC**: Virtual Private Cloud with public/private subnets
- **EC2**: Web application infrastructure with auto-scaling
- **EKS**: Kubernetes cluster with managed node groups
- **RDS**: Relational database with Multi-AZ deployment
- **Role**: IAM roles and policies for service access

## 📁 Project Structure

```
terraform-main/
├── VPC/                    # VPC infrastructure module
│   ├── main.tf
│   ├── variables.tf
│   ├── provider.tf
│   ├── backend.tf
│   ├── environments/
│   │   └── prod/
│   │       ├── prod.conf
│   │       └── prod.tfvars
│   └── modules/
│       └── vpc/
├── EC2/                    # EC2 web application module
│   ├── main.tf
│   ├── variables.tf
│   ├── provider.tf
│   ├── backend.tf
│   ├── installNginx.sh     # Nginx installation script
│   ├── keys/
│   │   └── my-ec2-key.pub
│   ├── environments/
│   └── modules/
│       ├── vpc/
│       ├── sg/
│       └── instance/
├── EKS/                    # Kubernetes cluster module
│   ├── main.tf
│   ├── variables.tf
│   ├── provider.tf
│   ├── backend.tf
│   ├── environments/
│   └── modules/
│       ├── vpc/
│       ├── role/
│       └── eks/
├── RDS/                    # Database module
│   ├── main.tf
│   ├── variables.tf
│   ├── provider.tf
│   ├── backend.tf
│   ├── image/
│   │   └── getting-started-mysql.png
│   ├── keys/
│   ├── environments/
│   └── modules/
│       ├── vpc/
│       ├── sg/
│       ├── rds/
│       └── instance/
├── Role/                   # IAM roles module
│   ├── main.tf
│   ├── variables.tf
│   ├── provider.tf
│   ├── backend.tf
│   ├── environments/
│   └── modules/
│       └── role/
└── LICENSE
```

## 🚀 Quick Start

### Prerequisites

- **Terraform** >= 1.0.0
- **AWS CLI** configured with appropriate credentials
- **AWS Account** with necessary permissions
- **SSH Key Pair** for EC2 access (if using EC2 module)

### 1. Clone the Repository

```bash
git clone <repository-url>
cd terraform-main
```

### 2. Configure AWS Credentials

```bash
# Option 1: AWS CLI configuration
aws configure

# Option 2: Environment variables
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-west-2"
```

### 3. Choose Your Module

Navigate to the desired module directory:

```bash
# For VPC only
cd VPC

# For EC2 web application
cd EC2

# For EKS cluster
cd EKS

# For RDS database
cd RDS

# For IAM roles
cd Role
```

### 4. Configure Variables

Copy and modify the production variables:

```bash
cp environments/prod/prod.tfvars environments/prod/my-environment.tfvars
```

Edit the variables according to your requirements.

### 5. Deploy Infrastructure

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

## 📋 Module Details

### VPC Module

Creates a complete Virtual Private Cloud infrastructure:

- **VPC** with DNS support
- **Public subnets** across multiple AZs
- **Private subnets** across multiple AZs
- **Internet Gateway** for public access
- **Route tables** and associations

**Key Features:**
- Multi-AZ deployment
- Configurable CIDR blocks
- Cross-account access support

### EC2 Module

Deploys web application infrastructure:

- **VPC** and networking components
- **Security groups** with configurable rules
- **EC2 instances** with auto-scaling
- **Automatic Nginx installation**
- **SSH key management**

**Key Features:**
- Auto-scaling capabilities
- Security group automation
- Application deployment scripts
- Public/private subnet deployment

### EKS Module

Provisions a complete Kubernetes cluster:

- **EKS cluster** with configurable version
- **Managed node groups** with auto-scaling
- **IAM roles** for cluster and nodes
- **EKS addons** (VPC CNI, kube-proxy, CoreDNS)
- **Access management** with IAM integration

**Key Features:**
- Kubernetes version management
- Node group auto-scaling
- Essential addons included
- IAM access control

### RDS Module

Creates a production-ready database:

- **RDS instance** with Multi-AZ support
- **Subnet groups** for high availability
- **Security groups** for database access
- **Parameter groups** for optimization
- **Backup and encryption** enabled

**Key Features:**
- Multi-AZ deployment
- Automated backups
- Storage encryption
- Security group isolation

### Role Module

Manages IAM roles and policies:

- **Service roles** for AWS services
- **Trust policies** for role assumption
- **Managed policies** attachment
- **Cross-account access** support

**Key Features:**
- Service-specific roles
- Policy management
- Cross-account configuration
- Security best practices

## 🔧 Configuration Examples

### VPC Configuration

```hcl
# VPC settings
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
region = "us-west-2"
```

### EC2 Configuration

```hcl
# EC2 settings
create_webapp = true
webapp_instance_types = ["t2.micro", "t2.small"]
ami_id = "ami-0abcdef1234567890"
instance_name = "webapp-instance"

# Security group rules
webapp_cidr_rules = [
  ["0.0.0.0/0", "22", "tcp", "SSH access"],
  ["0.0.0.0/0", "80", "tcp", "HTTP access"],
  ["0.0.0.0/0", "443", "tcp", "HTTPS access"]
]
```

### EKS Configuration

```hcl
# EKS settings
eks_cluster_name = "my-eks-cluster"
eks_version = "1.33"
eks_desired_size = 2
eks_max_size = 5
eks_min_size = 1
eks_instance_type = "t3.medium"

# EKS addons
eks_addons = [
  {
    name    = "vpc-cni"
    version = "v1.19.5-eksbuild.1"
  },
  {
    name    = "kube-proxy"
    version = "v1.33.0-eksbuild.2"
  }
]
```

### RDS Configuration

```hcl
# RDS settings
rds_instance_identifier = "my-database"
rds_engine = "mysql"
rds_engine_version = "8.0"
rds_instance_class = "db.t3.micro"
rds_allocated_storage = 20
rds_multi_az = true
rds_storage_encrypted = true
```

## 🔐 Security Considerations

### General Security

- **Private subnets** for sensitive resources
- **Security groups** with minimal required access
- **IAM roles** with least privilege principle
- **Encryption** enabled for data at rest
- **VPC Flow Logs** for network monitoring

### Access Control

- **SSH key management** for EC2 access
- **IAM access entries** for EKS clusters
- **Cross-account roles** for multi-account setups
- **Security group rules** reviewed regularly

### Data Protection

- **RDS encryption** enabled by default
- **Backup retention** configured appropriately
- **Parameter groups** for security hardening
- **Network isolation** through VPC design

## 💰 Cost Optimization

### Resource Sizing

- Use **t2.micro** instances for development
- Configure **auto-scaling** to match demand
- Choose **appropriate RDS instance classes**
- Use **Spot instances** for non-critical workloads

### Storage Optimization

- **EBS optimization** for EC2 instances
- **GP3 volumes** for better price/performance
- **Lifecycle policies** for backup management
- **Right-sizing** based on actual usage

### Network Costs

- **Private subnets** to reduce NAT Gateway costs
- **VPC endpoints** for AWS service access
- **Consolidated billing** for multiple accounts
- **Resource tagging** for cost allocation

## 🛠️ Troubleshooting

### Common Issues

1. **Insufficient permissions**: Check IAM roles and policies
2. **Resource limits**: Verify AWS service limits
3. **Network connectivity**: Review security group rules
4. **State conflicts**: Use proper backend configuration

### Debugging Commands

```bash
# Validate configuration
terraform validate

# Format code
terraform fmt

# Show current state
terraform show

# List resources
terraform state list

# Refresh state
terraform refresh
```

### Getting Help

1. Check the individual module README files
2. Review AWS documentation
3. Enable Terraform debug logging: `export TF_LOG=DEBUG`
4. Check CloudTrail logs for API errors

## 🔄 Backend Configuration

All modules support S3 backend for state management:

```hcl
terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "module-name/terraform.tfstate"
    region = "us-west-2"
  }
}
```

## 🌍 Environment Management

The repository supports multiple environments:

- **Production** (`environments/prod/`)
- **Development** (create as needed)
- **Staging** (create as needed)

Each environment has its own:
- Configuration files (`*.conf`)
- Variable files (`*.tfvars`)
- State files (if using local backend)

## 📚 Additional Resources

### Module-Specific Documentation

- [EC2 Module README](EC2/README.md) - Web application deployment
- [EKS Module README](EKS/README.md) - Kubernetes cluster setup
- [RDS Module README](RDS/readme.md) - Database deployment guide
- [VPC Module README](VPC/README.md) - Network infrastructure
- [Role Module README](Role/README.md) - IAM roles and policies

### External Resources

- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly in a development environment
5. Update documentation
6. Submit a pull request

### Development Guidelines

- Follow Terraform best practices
- Use consistent naming conventions
- Add proper variable descriptions
- Include example configurations
- Update README files for changes

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For issues and questions:

1. Check the troubleshooting section above
2. Review individual module documentation
3. Search existing issues in the repository
4. Create a new issue with detailed information

---

**⚠️ Important**: Always review and test configurations in a development environment before applying to production. Ensure you have proper backups and understand the impact of changes before deployment.