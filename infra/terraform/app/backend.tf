terraform {
  backend "s3" {
    bucket         = "terraform-state-todo-app-hiroyuki"
    key            = "app/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
