#---------------output alb id -------------------#

# output "lb_dns_name" {
#   value       = "http://${module.alb.lb_dns_name}/"
#   description = "DNS name of ALB."
# }

# output "dns_a_record_route53" {
#   value       = "https://${aws_route53_record.spider-shlomo-com.name}"
#   description = "a record for alb."
# }

# #---------------all relavte to username-------------------#

# output "user_username" {
#   value = aws_iam_user_login_profile.credentials.id
# }

# output "user_alias_name" {
#   value = data.aws_iam_account_alias.current.account_alias
# }

# output "user_password" {
#   value     = aws_iam_user_login_profile.credentials.password
#   sensitive = true
# }

# output "user_secret" {
#   value     = aws_iam_access_key.credentials.secret
#   sensitive = true
# }

# output "user_access_key" {
#   value = aws_iam_access_key.credentials.id
#}



#---------------output EC2s id -------------------#

# output "ec2_instances" {
#   description = "ID of the EC2 instance2"
#   value = { for i, v in module.ec2_instance_public : i => v.id }

# }


#---------------output target_group_arns -------------------#

# output "target_group_arns" {
#   value = module.alb.target_group_arns.id
# }

output "dns_a_record_route53" {
  value       = "https://blackjack.spider-shlomo.com"
  description = "a record for alb."
}


output "arn_waf" {
  value       = module.waf.web_acl_arn
  description = "arn"
}
