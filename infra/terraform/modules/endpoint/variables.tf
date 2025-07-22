variable "aws_region" {
  description = "AWS region (used for VPC endpoint)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the VPC endpoints will be created"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for interface endpoints"
  type        = list(string)
}

variable "private_route_table_id" {
  description = "ID of the private route table for S3 VPC endpoint"
  type        = string
}

variable "endpoint_sg_id" {
  description = "Security group ID used by VPC endpoints (ECR API/DKR)"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}