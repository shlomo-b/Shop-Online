# resource "aws_customer_gateway" "main" {
#   bgp_asn    = 65000
#   ip_address = "84.228.161.67"
#   type       = "ipsec.1"

#   tags = {
#     Name = "main-customer-gateway"
#   }
# }

# module "tgw" {
#   source  = "terraform-aws-modules/transit-gateway/aws"
#   version = "~> 2.0"

#   name        = "my-tgw"
#   description = "My TGW shared with several other AWS accounts"

#   enable_auto_accept_shared_attachments = true

#   vpc_attachments = {
#     vpc = {
#       vpc_id       = module.vpc["vpc-one"].vpc_id

#         subnet_ids               = [
#         module.vpc["vpc-one"].public_subnets[0],
#         module.vpc["vpc-one"].public_subnets[1]
#     ]

#       dns_support  = true
#       ipv6_support = false
#       tgw_routes = [
#         {
#           destination_cidr_block = "30.0.0.0/16"
#         },
#         {
#           blackhole = true
#           destination_cidr_block = "40.0.0.0/20"
#         }
#       ]
#     }
#   }

#   ram_allow_external_principals = true
#   ram_principals = [307990089504]

#   tags = {
#     Purpose = "tgw-complete-example"
#   }
# }