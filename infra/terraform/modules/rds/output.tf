output "rds_db_name" {
  description = "The name of the RDS instance"
  value       = aws_db_instance.mysql.db_name
  
}

output "rds_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.mysql.endpoint
}

output "rds_port" {
  description = "The port on which the DB accepts connections"
  value       = aws_db_instance.mysql.port
}

output "rds_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.mysql.arn
}

output "rds_identifier" {
  description = "The RDS instance identifier"
  value       = aws_db_instance.mysql.id
}