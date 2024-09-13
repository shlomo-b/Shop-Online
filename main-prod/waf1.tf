# module "waf" {
#   for_each = var.waf

#   source  = "umotif-public/waf-webaclv2/aws"
#   version = "~> 5.0.0"

#   name_prefix = "blackjack-waf"
#   alb_arn     = module.alb.lb_arn # the arn of the alb 
#   create_alb_association = true
#   allow_default_action = false  # block all the request https

#   providers = {
#     aws = aws.us-east
#   }

#   #  it's for show the logs of allow or block
#   visibility_config = {
#     cloudwatch_metrics_enabled = true
#     metric_name                = "blackjack-waf-logs"
#     sampled_requests_enabled   = true
#   }

#   # rules for access to application blackjack  
#   rules = [
#     {
#       # rules for ipsets  
#       name     = each.key
#       priority = each.value.priority
#       action   = each.value.action

#       visibility_config = {
#         cloudwatch_metrics_enabled = each.value.cloudwatch_metrics_enabled
#         metric_name                = each.value.metric_name
#         sampled_requests_enabled   = each.value.sampled_requests_enabled
#       }

#       ip_set_reference_statement ={ 
#         arn =  aws_wafv2_ip_set.allow_block_ips[each.key].arn # export the arm of the ipset
#     }},

#     {
#       regex_pattern_set_reference_statement ={ 
#         arn =  aws_wafv2_regex_pattern_set.block_allow_wildcard[each.key].arn # export the arm of the ipset
#         field_to_match = {
#         uri_path =  "{}"
#          }
#         priority  =  2
#         type      =   "LOWERCASE" # The text transformation type

#     }  
#     }  
#   ]
# }

# # ipsets allow only my IPs using for_each
# resource "aws_wafv2_ip_set" "allow_block_ips" {
#   for_each = var.waf

#   name               = each.key
#   description        = each.value.description
#   scope              = each.value.scope
#   ip_address_version = each.value.ip_address_version
#   addresses          = each.value.addresses
# }


# # # creare regex to block/allow after the / slash
# # resource "aws_wafv2_regex_pattern_set" "block_allow_wildcard" {
# #   for_each = var.waf

# #   name        = each.key
# #   scope       = each.value.scope
  
# #   regular_expression {

# #     # block/allow after the / slash
# #     regex_string =  each.value.regex_string
# #   }
# # }

# # the region when the ALB exsit 
# provider "aws" {
#   alias  = "us-east"
#   region = "us-east-1"
# }
