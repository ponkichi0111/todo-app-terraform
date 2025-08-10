# RDS Instance
resource "aws_db_instance" "mysql" {
  identifier              = var.db_identifier
  engine                  = var.db_engine
  engine_version          = var.db_engine_version
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage
  db_name                 = var.db_name
  username                = var.db_username
  db_subnet_group_name    = aws_db_subnet_group.mysql.name
  vpc_security_group_ids  = var.vpc_security_group_ids
  skip_final_snapshot     = true
  publicly_accessible     = false
  multi_az                = false
  deletion_protection     = false
  apply_immediately       = true

  manage_master_user_password    = true

  tags = {
    Name = var.db_identifier
  }
}

# DB Subnet Group
resource "aws_db_subnet_group" "mysql" {
  name       = "${var.db_identifier}-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "${var.db_identifier}-subnet-group"
  }
}