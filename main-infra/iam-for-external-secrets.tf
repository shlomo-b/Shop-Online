# # role for external-secrets

# module "iam_eks_role" {
#   source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
#   role_name = "external-secrets-role"
  
#   role_policy_arns = {
#     policy = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
#   }
  
#   oidc_providers = {
#     one = {
#       provider_arn               =  module.eks.oidc_provider_arn
#       namespace_service_accounts = ["external-secrets:external-secrets"]
#     }
#   }
#   depends_on = [ 
#     module.eks
#    ]
# }