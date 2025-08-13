variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "db_name" {
  type        = string
  description = "DB名"
}

variable "db_username" {
  type        = string
  description = "DBユーザー名"
}

variable "db_engine" {
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  type        = string
  default     = "8.0"
}

variable "db_instance_class" {
  type        = string
  default     = "db.t4g.micro"
}

variable "db_allocated_storage" {
  type        = number
  default     = 20
}

variable "db_identifier" {
  description = "Identifier for the RDS instance"
  type        = string
}

variable "alb_target_port" {
  description = "Port on which targets receive traffic"
  type        = number
  default     = 80
}

variable "alb_health_check_path" {
  description = "Health check path for ALB"
  type        = string
  default     = "/"
}

variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "todo-ecs-cluster"
}

variable "backend_cw_name" {
  description = "The name of the CloudWatch log group for the backend service"
  type        = string
  default     = "/ecs/todo-app/backend"
}

variable "frontend_cw_name" {
  description = "The name of the CloudWatch log group for the frontend service"
  type        = string
  default     = "/ecs/todo-app/frontend"
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