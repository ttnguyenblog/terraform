output "public_subnets_id" {
  description = "List of subnet IDs in the VPC"
  value       = aws_subnet.public_subnets[*].id
}