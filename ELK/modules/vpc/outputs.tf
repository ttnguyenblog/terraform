output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "public_subnets_id" {
  description = "List of subnet IDs in the VPC"
  value       = aws_subnet.public_subnets[*].id
}