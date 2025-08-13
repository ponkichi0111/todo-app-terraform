variable "rds_master_secret_arn" {
  description = "ARN of the RDS secret"
  type        = string
}

variable "ecs_app_task_role_name" {
  description = "Name of the ECS app task role"
  type        = string
  default     = "ecsAppTaskRole"
}

variable "github_repository" {
  description = "GitHub repository identifier (e.g., organization/repository)"
  type        = string
}