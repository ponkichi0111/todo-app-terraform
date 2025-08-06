resource "aws_cloudwatch_log_group" "backend" {
  name              = var.backend_cw_name
  retention_in_days = 30

  tags = {
    Environment = "production"
    Application = "todo-app"
  }
}

resource "aws_cloudwatch_log_group" "frontend" {
  name              = var.frontend_cw_name
  retention_in_days = 30

  tags = {
    Environment = "production"
    Application = "todo-app"
  }
}