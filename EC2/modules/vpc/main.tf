# Define VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block # Source CIDR block for the VPC 10.0.0.0/16
  enable_dns_hostnames = true               # Enable DNS hostnames and assigned to instances
  enable_dns_support   = true               # Enable DNS support for the VPC
  tags = {
    Name = "vpc" # Name of the VPC
  }
}


#Public Subnets
resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnets_cidr) # Identify the number of public subnets based on the provided CIDR blocks 10.0.0.0/27, 10.0.0.32/27, 10.0.0.64/27
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnets_cidr[count.index] # Use the CIDR block for each public subnet from the provided list
  # Use availability zone for each public subnet to identify AZ
  availability_zone = element(local.availability_zones, count.index)
  map_public_ip_on_launch = true # Auto assign public IPs to instances launched in this subnet

  tags = {
    Name = "subnet-public-${count.index + 1}-${element(local.availability_zones, count.index)}"
  }
}


#Private Subnets
resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnets_cidr)
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnets_cidr[count.index]
  availability_zone = element(local.availability_zones, count.index)

  tags = {
    Name = "subnet-private-${count.index + 1}-${element(local.availability_zones, count.index)}"
  }
  
}


#Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw"
  }
}

#Route Table for Public Subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "public-route-table"
  }
}


# Route for Internet Gateway
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Route table associations for both Public
resource "aws_route_table_association" "public_subnet_association" {
  count          = length(aws_subnet.public_subnets) # Create associations for each public subnet
  subnet_id      = aws_subnet.public_subnets[count.index].id # Use the subnet ID for each public subnet
  route_table_id = aws_route_table.public_route_table.id # Use the public route table for associations
}

# Route Table for Private Subnets
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "private-route-table"
  }
}

# Route table associations for Private Subnets
resource "aws_route_table_association" "private_subnet_association" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}
