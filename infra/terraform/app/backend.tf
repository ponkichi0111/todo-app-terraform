terraform {
  backend "s3" {
    bucket         = "terraform-state-todo-app"
    key            = "app/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
