output "ecr_backend_repo_name" {
  description = "The name of the ECR repository for the backend service"
  value = module.ecr.backend_repo_url
}

output "ecr_frontend_repo_name" {
  description = "The name of the ECR repository for the frontend service"
  value = module.ecr.frontend_repo_url
}