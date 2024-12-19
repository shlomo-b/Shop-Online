# resource "aws_secretsmanager_secret" "secrets" {
#   name        = "database-credentials"
#   description = "Credentials for my database"
#   recovery_window_in_days = 0
# }

# resource "aws_secretsmanager_secret_version" "database_credentials" {
#   secret_id     = aws_secretsmanager_secret.secrets.id
#   secret_string = jsonencode({
#     DATABASE_HOST     = module.db.db_instance_endpoint
#     DATABASE_NAME     = "mydbpostgres"
#     DATABASE_USER     = "postgres"
#     DATABASE_PASSWORD = "TZkv70%RE$!$7bm!"
#     recovery_window_in_days = 0
#   })
#   # depends_on = [ module.db ]
# }


resource "aws_secretsmanager_secret" "secrets" {
  name        = "DB-CREDENTIALS"
  description = "Credentials for my database"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id     = aws_secretsmanager_secret.secrets.id
  secret_string = jsonencode({
    MONGO_INITDB_ROOT_USERNAME = file("../secrets/mongo-username.txt")
    MONGO_INITDB_ROOT_PASSWORD = file("../secrets/mongo-password.txt")
    recovery_window_in_days = 0
  })
  # depends_on = [ module.db ]
}
