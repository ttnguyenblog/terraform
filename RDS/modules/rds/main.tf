#Define Subnet Group for RDS Service
resource "aws_db_subnet_group" "rds-subnet-group" {
  name        = var.rds_subnet_group_name
  description = "Subnet group for RDS instance"
  subnet_ids  = var.private_subnet_ids
  tags = {
    Name = var.rds_subnet_group_name
  }
}

#Create RDS Instance
resource "aws_db_instance" "rds-instance" {
  identifier              = var.rds_instance_identifier

  allocated_storage       = var.rds_allocated_storage
  storage_type            = var.rds_storage_type

  engine                  = var.rds_engine
  engine_version          = var.rds_engine_version
  instance_class          = var.rds_instance_class

  username                = var.rds_username
  password                = var.rds_password
  parameter_group_name    = var.rds_parameter_group_name
  skip_final_snapshot     = var.rds_skip_final_snapshot
  db_subnet_group_name    = aws_db_subnet_group.rds-subnet-group.name
  vpc_security_group_ids  = [var.rds_security_group_id]
  multi_az                = var.rds_multi_az
  publicly_accessible     = var.rds_pulicly_accessible
  storage_encrypted       = var.rds_storage_encrypted
  backup_retention_period = var.rds_backup_retention_period
  tags = {
    Name = var.rds_instance_identifier
  }
}
