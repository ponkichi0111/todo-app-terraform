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