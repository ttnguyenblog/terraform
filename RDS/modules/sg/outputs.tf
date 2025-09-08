output "security_group_id_webapp" {
  description = "The ID of the security group"
  value       = aws_security_group.webapp_sg.id
}

output "security_group_id_rds" {
  description = "The ID of the security group"
  value       = aws_security_group.rds_sg.id
}


