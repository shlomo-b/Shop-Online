#---------------output alb id -------------------#

# output "lb_dns_name" {
#   value       = "http://${module.alb.lb_dns_name}/"
#   description = "DNS name of ALB."
# }

# output "dns_a_record_route53" {
#   value       = "https://${aws_route53_record.spider-shlomo-com.name}"
#   description = "a record for alb."
# }

#---------------output EC2s id -------------------#

output "dns_a_record_route53" {
  value       = "https://frontend.spider-shlomo-com"
  description = "a record for alb."
}

# output "arn_waf" {
#   value       = module.waf.web_acl_arn
#   description = "arn"
# }

# output "rds" {
#   value       = module.db.db_instance_endpoint
#   description = "rds"
# }

# output "vpc_public_subnets" {
#   value = { for k, v in module.vpc : k => v.public_subnets }
#   description = "vpcs"
# }

# output "acms-arn" {
#   value       = { for k, v in module.acm : k => v.acm_certificate_arn }
#   description = "acms"
# }

# output "sgs" {
#   value       = { for k, v in module.sgs : k => v.security_group_id }
#   description = "sgs"
# }

# output "db_credentials_secret" {
#   # terraform output db_credentials_secre
#   value = jsondecode(aws_secretsmanager_secret_version.db_credentials.secret_string)
#   sensitive = true
# }

# output "role-external-secrets" {
#   value       = aws_iam_role.external_secrets_role.arn
#   description = "external-secrets"
# }


# output "cluster_oidc_issuer_url" {
#   description = "The OIDC issuer URL of the EKS cluster"
#   value       = module.eks.cluster_oidc_issuer_url
# }

# The full OIDC provider ARN

# output "cluster_oidc_provider_arn" {
#   description = "The ARN of the OIDC Provider"
#   value       = module.eks.oidc_provider_arn
# }