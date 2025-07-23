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

variable "db_password" {
  type        = string
  description = "DBパスワード"
  sensitive   = true
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