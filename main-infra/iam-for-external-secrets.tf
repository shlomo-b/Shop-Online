# Create IAM user for external-secrets
resource "aws_iam_user" "external_secrets" {
  name = "external-secrets"

  tags = {
    creator = "external-secrets"
  }
}

# Create access key for the external-secrets user
resource "aws_iam_access_key" "external_secrets_access_key" {
  user = aws_iam_user.external_secrets.name
}

# Attach the SecretsManagerReadWrite policy to the external-secrets user
resource "aws_iam_user_policy_attachment" "external_secrets_policy" {  
  user       = aws_iam_user.external_secrets.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  
}

# Create CSV content with the access key and secret key
locals {
  external_secrets_keys_csv = "access_key,secret_key\n${aws_iam_access_key.external_secrets_access_key.id
    },${aws_iam_access_key.external_secrets_access_key.secret}"
}

# Save the access keys into a CSV file
resource "local_file" "external_secrets_keys" {
  content  = local.external_secrets_keys_csv
  filename = "secrets.csv"
}