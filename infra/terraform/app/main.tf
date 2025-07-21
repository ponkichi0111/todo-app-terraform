module "vpc" {
  source               = "../modules/vpc"
  name_prefix          = var.name_prefix
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  aws_region           = var.aws_region
  endpoint_sg_id       = module.security.endpoint_sg_id
}

module "security" {
  source      = "../modules/security"
  vpc_id      = module.vpc.vpc_id
  name_prefix = var.name_prefix
}