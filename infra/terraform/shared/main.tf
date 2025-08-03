module "ecr" {
  source             = "../modules/ecr"
  backend_repo_name  = var.backend_repo_name
  frontend_repo_name = var.frontend_repo_name
}