output "target_group_arn" {
  description = "The ARN of the target group for the ECS service"
  value = module.alb.target_group_arn
}

output "subnet_ids" {
  description = "The subnet IDs for the ECS service"
  value = module.vpc.private_subnet_ids
}

output "security_group_ids" {
  description = "The security group IDs for the ECS service"
  value = module.security.ecs_sg_id
}

output "rds_db_name" {
  description = "The name of the RDS instance"
  value       = module.rds.rds_db_name
}

output "rds_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = module.rds.rds_endpoint
  
}