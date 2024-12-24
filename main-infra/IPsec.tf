resource "aws_customer_gateway" "main" {
  bgp_asn    = 65000
  ip_address = "84.228.161.67"
  type       = "ipsec.1"

  tags = {
    Name = "main-customer-gateway"
  }
}

resource "aws_vpn_gateway" "main" {
  tags = {
    Name = "main-vpn-gateway"
  }
}

module "vpn_gateway" {
  source  = "terraform-aws-modules/vpn-gateway/aws"
  version = "~> 3.0"

  vpc_id                  = module.vpc["vpc-one"].vpc_id
  vpn_gateway_id          = aws_vpn_gateway.main.id
  customer_gateway_id     = aws_customer_gateway.main.id #aws_customer_gateway.main

  # precalculated length of module variable vpc_subnet_route_table_ids
  vpc_subnet_route_table_count =  2
  vpc_subnet_route_table_ids   = [
    module.vpc["vpc-one"].private_route_table_ids[0],
    module.vpc["vpc-one"].private_route_table_ids[1]
  ]
}

locals {
  vpn_outputs = <<EOF
{
  "tunnel1_preshared_key": "${module.vpn_gateway.tunnel1_preshared_key}",
  "tunnel2_preshared_key": "${module.vpn_gateway.tunnel2_preshared_key}",
  "vpn_connection_id": "${module.vpn_gateway.vpn_connection_id}",
  "vpn_connection_transit_gateway_attachment_id": "${module.vpn_gateway.vpn_connection_transit_gateway_attachment_id}",
  "vpn_connection_tunnel1_address": "${module.vpn_gateway.vpn_connection_tunnel1_address}",
  "vpn_connection_tunnel1_cgw_inside_address": "${module.vpn_gateway.vpn_connection_tunnel1_cgw_inside_address}",
  "vpn_connection_tunnel1_vgw_inside_address": "${module.vpn_gateway.vpn_connection_tunnel1_vgw_inside_address}",
  "vpn_connection_tunnel2_address": "${module.vpn_gateway.vpn_connection_tunnel2_address}",
  "vpn_connection_tunnel2_cgw_inside_address": "${module.vpn_gateway.vpn_connection_tunnel2_cgw_inside_address}",
  "vpn_connection_tunnel2_vgw_inside_address": "${module.vpn_gateway.vpn_connection_tunnel2_vgw_inside_address}"
}
EOF
}

# Save VPN configuration to a text file
resource "local_file" "vpn_output" {
  content  = local.vpn_outputs
  filename = "${path.module}/vpn_config_output.txt"
}