#---------------vpc-------------------#

module "vpc" {
  for_each                = var.vpcs
  
  source                  = "terraform-aws-modules/vpc/aws"
  version                 = "5.8.1"

  name                    = each.key
  cidr                    = each.value.cidr
  azs                     = each.value.azs
  private_subnets         = each.value.private_subnets
  public_subnets          = each.value.public_subnets
  map_public_ip_on_launch = true
 # enable_nat_gateway     = true
  enable_vpn_gateway      = false
  enable_dns_hostnames    = true
  enable_dns_support      = true
  manage_default_network_acl = false
  manage_default_security_group = false
}