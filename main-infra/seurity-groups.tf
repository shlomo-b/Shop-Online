#---------------security_group-------------------#

# resource "aws_security_group" "sgs" {
#   for_each                = var.sgs

#   name   = each.key # each.key = vpc_name
#   vpc_id = data.aws_vpc.vpcs_name[each.key].id # to work with vpc name and not vpc id
  
#   tags = {
#     name = each.value.tags.name
#   }

#  dynamic "ingress" { # 
#   for_each = each.value.ingress # for each value in ingress | the dynamic is used for create some values in ingress

#   content {
#     # for each value in content ingress

#     description = ingress.value.description
#     from_port   = ingress.value.from_port  
#     to_port     = ingress.value.to_port     
#     protocol    = ingress.value.protocol    
#     cidr_blocks = ingress.value.cidr_blocks
#   }
# }
#   egress { # each value in egress
#     description = each.value.egress.description
#     from_port   = each.value.egress.from_port
#     to_port     = each.value.egress.to_port
#     protocol    = each.value.egress.protocol
#     cidr_blocks = each.value.egress.cidr_blocks
#   }
# }

# # this is for work with vpc name and not vpc id.
# data "aws_vpc" "vpcs_name" {
#   for_each = var.sgs
  
#   filter {
#     name   = "tag:Name"
#     values = [each.value.vpc_name]
#   }
# }


module "sgs" {
  for_each = var.sgs

  source = "terraform-aws-modules/security-group/aws"

  name        = each.key
  description = each.value.description
  vpc_id      = module.vpc[each.value.vpc_key].vpc_id # retune the value of the vpss , and take the vpc_id

  ingress_cidr_blocks      = each.value.ingress_cidr_blocks
  ingress_with_cidr_blocks = [
    for rule in each.value.ingress_with_cidr_blocks : # for each all the values in ingress_with_cidr_blocks from file tfvars
    {
      from_port   = rule.from_port
      to_port     = rule.to_port
      protocol    = rule.protocol
      description = rule.description  
      cidr_blocks = rule.cidr_blocks
    }
  ]
  # egress default rule
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "default egress"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

# module "vote_service_sg" {
#   source = "terraform-aws-modules/security-group/aws"

#   name        = "user-service"
#   description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
#   vpc_id      = module.vpc["vpc-two"].vpc_id

#   ingress_cidr_blocks      = [module.vpc["vpc-two"].vpc_cidr_block]
#   ingress_with_cidr_blocks = [
#     {
#       from_port   = 8080
#       to_port     = 8090
#       protocol    = "tcp"
#       description = "User-service ports"
#       cidr_blocks = "10.10.0.0/16"
#     }
#   ]
#   egress_with_cidr_blocks = [
#     {
#       from_port   = 0
#       to_port     = 0
#       protocol    = "-1"
#       description = "de"
#       cidr_blocks = "0.0.0.0/0"
#     }
#   ]
# }