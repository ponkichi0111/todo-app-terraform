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

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "backend_log_group_name" {
  description = "The name of the CloudWatch log group for the backend service"
  value       = module.cloudwatchlogs.backend_cw_name
}

output "frontend_log_group_name" {
  description = "The name of the CloudWatch log group for the frontend service"
  value       = module.cloudwatchlogs.frontend_cw_name
}