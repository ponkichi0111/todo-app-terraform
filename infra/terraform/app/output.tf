output "target_group_arn" {
  value = module.alb.target_group_arn
}

output "subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "security_group_ids" {
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