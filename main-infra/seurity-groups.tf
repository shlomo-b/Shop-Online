#---------------security_group-------------------#

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