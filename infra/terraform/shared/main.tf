module "ecr" {
  source             = "../modules/ecr"
  backend_repo_name  = var.backend_repo_name
  frontend_repo_name = var.frontend_repo_name
}

module "github_oidc" {
  source = "../modules/github_oidc"

  github_repository      = var.github_repository
}