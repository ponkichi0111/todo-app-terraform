module "vpc" {
  source               = "../modules/vpc"
  name_prefix          = var.name_prefix
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "security" {
  source      = "../modules/security"
  vpc_id      = module.vpc.vpc_id
  name_prefix = var.name_prefix
}

module "endpoint" {
  source                 = "../modules/endpoint"
  aws_region             = var.aws_region
  vpc_id                 = module.vpc.vpc_id
  private_subnet_ids     = module.vpc.private_subnet_ids
  private_route_table_id = module.vpc.private_route_table_id
  endpoint_sg_id         = module.security.endpoint_sg_id
  name_prefix            = var.name_prefix
}

module "rds" {
  source                 = "../modules/rds"
  db_name                = var.db_name
  db_username            = var.db_username
  db_engine              = var.db_engine
  db_engine_version      = var.db_engine_version
  db_instance_class      = var.db_instance_class
  db_allocated_storage   = var.db_allocated_storage
  vpc_security_group_ids = [module.security.database_sg_id]
  db_subnet_ids          = module.vpc.private_subnet_ids
  db_identifier          = var.db_identifier
}

module "alb" {
  source             = "../modules/alb"
  name_prefix        = var.name_prefix
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  security_group_ids = [module.security.alb_sg_id]
  target_port        = var.alb_target_port
  health_check_path  = var.alb_health_check_path
}

module "ecs" {
  source          = "../modules/ecs"
  cluster_name    = var.cluster_name
}

module "cloudwatchlogs" {
  source = "../modules/cloudwatchlogs"

  backend_cw_name  = var.backend_cw_name
  frontend_cw_name = var.frontend_cw_name
}

module "iam" {
  source = "../modules/iam"

  rds_master_secret_arn  = module.rds.rds_master_secret_arn
  ecs_app_task_role_name = var.ecs_app_task_role_name
}