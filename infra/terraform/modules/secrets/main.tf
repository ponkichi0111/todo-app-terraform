resource "aws_secretsmanager_secret" "db_user" {
  name = var.db_user
}

resource "aws_secretsmanager_secret_version" "db_user_value" {
  secret_id     = aws_secretsmanager_secret.db_user.id
  secret_string = var.db_user_value
}

resource "aws_secretsmanager_secret" "db_password" {
  name = var.db_password
}

resource "aws_secretsmanager_secret_version" "db_password_value" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = var.db_password_value
}