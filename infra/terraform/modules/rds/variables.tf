variable "db_name" {
  description = "Name of the database to create"
  type        = string
}

variable "db_username" {
  description = "Master username for the database"
  type        = string
}

variable "db_password" {
  description = "Master password for the database"
  type        = string
  sensitive   = true
}

variable "db_engine" {
  description = "The database engine to use (e.g., mysql or postgres)"
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "The version of the database engine"
  type        = string
  default     = "8.0"
}

variable "db_instance_class" {
  description = "The instance type of the RDS"
  type        = string
  default     = "db.t4g.micro"
}

variable "db_allocated_storage" {
  description = "The allocated storage in GB"
  type        = number
  default     = 20
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
}

variable "db_subnet_ids" {
  description = "List of subnet IDs for the RDS subnet group"
  type        = list(string)
}

variable "db_identifier" {
  description = "Identifier for the RDS instance"
  type        = string
}