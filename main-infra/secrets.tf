resource "aws_secretsmanager_secret" "secrets" {
  name        = "DB-CREDENTIALS"
  description = "Credentials for my database"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id     = aws_secretsmanager_secret.secrets.id
  secret_string = jsonencode({
    MONGO_INITDB_ROOT_USERNAME = var.MONGO_INITDB_ROOT_USERNAME
    MONGO_INITDB_ROOT_PASSWORD = var.MONGO_INITDB_ROOT_PASSWORD
    recovery_window_in_days = 0
    tags = {
      name = "my-secrets"
    }
  })
}
