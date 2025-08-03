module "ecr" {
  source             = "../modules/ecr"
  backend_repo_name  = var.backend_repo_name
  frontend_repo_name = var.frontend_repo_name
}

module "secrets" {
  source = "../modules/secrets"

  db_user           = var.db_user
  db_password       = var.db_password
  db_user_value     = var.db_user_value
  db_password_value = var.db_password_value
}

module "iam" {
  source = "../modules/iam"

  db_user_arn     = module.secrets.db_user_arn
  db_password_arn = module.secrets.db_password_arn

  ecs_app_task_role_name = var.ecs_app_task_role_name
}