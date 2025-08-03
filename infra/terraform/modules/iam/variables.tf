variable "db_user_arn" {
  description = "Secrets Manager の DBユーザー ARN"
  type        = string
}

variable "db_password_arn" {
  description = "Secrets Manager の DBパスワード ARN"
  type        = string
}

variable "ecs_app_task_role_name" {
  description = "Name of the ECS app task role"
  type        = string
  default     = "ecsAppTaskRole"
}