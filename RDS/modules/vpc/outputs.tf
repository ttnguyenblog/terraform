output "private_subnets_ids" {
  description = "List of subnet IDs in the VPC"
  value       = aws_subnet.private_subnets[*].id
}

output "public_subnets_ids" {
  description = "List of subnet IDs in the VPC"
  value       = aws_subnet.public_subnets[*].id
  
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
  
}