resource "aws_ecr_repository" "backend" {
  name = var.backend_repo_name

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_ecr_repository" "frontend" {
  name = var.frontend_repo_name

  lifecycle {
    prevent_destroy = true
  }
}