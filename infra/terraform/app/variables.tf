variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-1"
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
  type    = string
  default = "mysql"
}

variable "db_engine_version" {
  type    = string
  default = "8.0"
}

variable "db_instance_class" {
  type    = string
  default = "db.t4g.micro"
}

variable "db_allocated_storage" {
  type    = number
  default = 20
}

variable "db_identifier" {
  description = "Identifier for the RDS instance"
  type        = string
}

variable "alb_target_port" {
  type    = number
  default = 80
}

variable "alb_health_check_path" {
  description = "Health check path for ALB"
  type        = string
  default     = "/"
}

variable "cluster_name" {
  type    = string
  default = "todo-cluster"
}

variable "backend_cw_name" {
  type    = string
  default = "/ecs/todo-app/backend"
}

variable "frontend_cw_name" {
  type    = string
  default = "/ecs/todo-app/frontend"
}

variable "ecs_app_task_role_name" {
  type    = string
  default = "ecsAppTaskRole"
}