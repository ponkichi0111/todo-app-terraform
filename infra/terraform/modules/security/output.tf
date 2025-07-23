output "endpoint_sg_id" {
  value = aws_security_group.endpoint.id
}

output "database_sg_id" {
  value = aws_security_group.database.id
}