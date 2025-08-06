output "backend_cw_name" {
  value = aws_cloudwatch_log_group.backend.name
}

output "frontend_cw_name" {
  value = aws_cloudwatch_log_group.frontend.name
}