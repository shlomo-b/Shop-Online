# resource "aws_customer_gateway" "main" {
#   ip_address = "84.228.161.67"
#   type       = "ipsec.1"
#   bgp_asn    = "65000"

#   tags = {
#     Name = "main-customer-gateway"
#   }
# }

# resource "aws_vpn_gateway" "main" {
#   tags = {
#     Name = "main-vpn-gateway"
#   }
#  # depends_on = [ module.vpn_gateway ]
# }

# resource "aws_vpn_connection" "main" {
#   vpn_gateway_id      = aws_vpn_gateway.main.id
#   customer_gateway_id = aws_customer_gateway.main.id
#   type                = "ipsec.1"

#   static_routes_only = true

#  lifecycle {
#     ignore_changes = [tags]
#  }
# }


# module "vpn_gateway" {
#   source  = "terraform-aws-modules/vpn-gateway/aws"
#   version = "~> 3.0"
#   vpc_id                  = module.vpc["vpc-one"].vpc_id
#   vpn_gateway_id          = aws_vpn_gateway.main.id
#   customer_gateway_id     = aws_customer_gateway.main.id #aws_customer_gateway.main
#   vpn_connection_static_routes_only = true
#   create_vpn_connection = true
#   vpn_connection_static_routes_destinations = ["0.0.0.0/0"]
#   # precalculated length of module variable vpc_subnet_route_table_ids
#   vpc_subnet_route_table_count =  2
#   vpc_subnet_route_table_ids   = [
#     module.vpc["vpc-one"].private_route_table_ids[0],
#     module.vpc["vpc-one"].private_route_table_ids[1]
#   ]
#   #tunnel1_inside_cidr   = "169.254.33.88/30"
#   #tunnel2_inside_cidr   = "169.254.33.100/30"
#   # tunnel1_preshared_key = "1234567890abcdefghijklmn"
#   #tunnel2_preshared_key = "abcdefghijklmn1234567890"
# }

# # Extract VPN configuration
# locals {
#   vpn_outputs = <<EOF
# {
#   "tunnel1_preshared_key": "${module.vpn_gateway.tunnel1_preshared_key}",
#   "tunnel2_preshared_key": "${module.vpn_gateway.tunnel2_preshared_key}",
#   "vpn_connection_id": "${module.vpn_gateway.vpn_connection_id}",
#   "vpn_connection_transit_gateway_attachment_id": "${module.vpn_gateway.vpn_connection_transit_gateway_attachment_id}",
#   "vpn_connection_tunnel1_address": "${module.vpn_gateway.vpn_connection_tunnel1_address}",
#   "vpn_connection_tunnel1_cgw_inside_address": "${module.vpn_gateway.vpn_connection_tunnel1_cgw_inside_address}",
#   "vpn_connection_tunnel1_vgw_inside_address": "${module.vpn_gateway.vpn_connection_tunnel1_vgw_inside_address}",
#   "vpn_connection_tunnel2_address": "${module.vpn_gateway.vpn_connection_tunnel2_address}",
#   "vpn_connection_tunnel2_cgw_inside_address": "${module.vpn_gateway.vpn_connection_tunnel2_cgw_inside_address}",
#   "vpn_connection_tunnel2_vgw_inside_address": "${module.vpn_gateway.vpn_connection_tunnel2_vgw_inside_address}"
# }
# EOF

# }

# # Save VPN configuration to a text file
# resource "local_file" "vpn_output" {
#   content  = local.vpn_outputs
#   filename = "${path.module}/vpn_config_output.txt"
# }

# # add those static routes to IPsec
# resource "aws_route" "lan-home" {
#   route_table_id         = module.vpc["vpc-one"].public_route_table_ids[0]
#   destination_cidr_block = "10.0.11.0/24"
#   gateway_id             = aws_vpn_gateway.main.id
#   depends_on = [ module.vpn_gateway ]
# }

# resource "aws_route" "monitoring" {
#   route_table_id         = module.vpc["vpc-one"].public_route_table_ids[0]
#   destination_cidr_block = "10.90.100.0/24"
#   gateway_id             = aws_vpn_gateway.main.id
#   depends_on = [module.vpn_gateway ]
# }