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