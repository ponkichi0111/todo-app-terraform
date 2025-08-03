variable "backend_repo_name" {
  description = "Backend ECR repository name"
  type        = string
  default     = "todo-backend"
}

variable "frontend_repo_name" {
  description = "Frontend ECR repository name"
  type        = string
  default     = "todo-frontend"
}

variable "db_user" {
  description = "Database user for the Todo application"
  type        = string
}

variable "db_password" {
  description = "Database password for the Todo application"
  type        = string
}

variable "db_user_value" {
  description = "Value for the database user"
  type        = string
}

variable "db_password_value" {
  description = "Value for the database password"
  type        = string
}