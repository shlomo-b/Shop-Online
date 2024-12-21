# Create an IAM role for external-secrets
# resource "aws_iam_role" "external_secrets_role" {
#   name = "external-secrets-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action    = "sts:AssumeRole"
#         Effect    = "Allow"
#         Principal = {
#           Service = "ec2.amazonaws.com" # Adjust the service based on your use case
#         }
#       }
#     ]
#   })

#   tags = {
#     creator = "external-secrets"
#   }
# }

# # Attach the SecretsManagerReadWrite policy to the role
# resource "aws_iam_policy_attachment" "external_secrets_policy" {
#   name       = "external-secrets-policy"
#   policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
#   roles      = [aws_iam_role.external_secrets_role.name]
# }

module "iam_eks_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  role_name = "external-secrets-role"
  
  role_policy_arns = {
    policy = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  }
  
  oidc_providers = {
    one = {
      provider_arn               =  module.eks.oidc_provider_arn
      namespace_service_accounts = ["external-secrets:external-secrets"]
    }
  }
}