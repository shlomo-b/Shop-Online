# #---------------security_group-------------------#

resource "aws_security_group" "sgs" {
  for_each                = var.sgs

  name   = each.key
  vpc_id = data.aws_vpc.vpcs_name[each.key].id # to work with vpc name and not vpc id
  
  tags = {
    name = each.value.tags.name
  }

 dynamic "ingress" { # 
  for_each = each.value.ingress # for each value in ingress | the dynamic is used for create some values in ingress

  content {
    # for each value in content ingress

    description = ingress.value.description
    from_port   = ingress.value.from_port  
    to_port     = ingress.value.to_port     
    protocol    = ingress.value.protocol    
    cidr_blocks = ingress.value.cidr_blocks
  }
}
  egress { # each value in egress
    description = each.value.egress.description
    from_port   = each.value.egress.from_port
    to_port     = each.value.egress.to_port
    protocol    = each.value.egress.protocol
    cidr_blocks = each.value.egress.cidr_blocks
  }
}

# this is for work with vpc name and not vpc id.
data "aws_vpc" "vpcs_name" {
  for_each = var.sgs
  
  filter {
    name   = "tag:Name"
    values = [each.value.vpc_name]
  }
}
