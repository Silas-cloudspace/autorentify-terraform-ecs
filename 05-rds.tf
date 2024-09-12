# Create a database subnet group
resource "aws_db_subnet_group" "database_subnet_group" {
  name       = "${var.project_name}-${var.environment}-database-subnets"
  description = "subnets for database instance"

  subnet_ids = [
    aws_subnet.private_data_subnet_az1.id,
    aws_subnet.private_data_subnet_az2.id
  ]

  tags = {
    Name = "${var.project_name}-${var.environment}-database-subnets"
  }
}

# Create the RDS instance
resource "aws_db_instance" "dev_rds_db" {
  identifier              = "dev-rds-db"
  engine                  = "mysql"
  engine_version          = "8.0.36"
  instance_class          = "db.t3.medium"
  skip_final_snapshot     = true
  allocated_storage       = 20
  max_allocated_storage   = 100
  db_subnet_group_name    = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.database_security_group.id]
  multi_az                = true 
  username                = var.db_master_username
  password                = var.db_master_password
  db_name                 = "applicationdb"
  storage_encrypted       = true
  backup_retention_period = 7
  parameter_group_name    = "mysql_para_group_name" 

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "dev-rds-db"
  }
}
