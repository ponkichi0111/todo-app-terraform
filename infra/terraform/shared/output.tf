output "ecr_backend_repo_name" {
  description = "The name of the ECR repository for the backend service"
  value = module.ecr.backend_repo_url
}

output "ecr_frontend_repo_name" {
  description = "The name of the ECR repository for the frontend service"
  value = module.ecr.frontend_repo_url
}

output "db_user_arn" {
  description = "The ARN of the database user"
  value       = module.secrets.db_user_arn
  
}

output "db_password_arn" {
  description = "The ARN of the database password"
  value       = module.secrets.db_password_arn
}

output "ecs_app_task_role_arn" {
  description = "The name of the ECS application task role"
  value       = module.iam.ecs_app_task_role_arn
}

output "ecs_task_execution_role_arn" {
  description = "The name of the ECS task execution role"
  value       = module.iam.ecs_task_execution_role_arn
}