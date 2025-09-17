resource "aws_route53_record" "spider-shlomo-com" {
  for_each = var.route53
  
  zone_id = data.aws_route53_zone.zone_id.zone_id # Hosted zone ID of the domain spider-shlomo.com
  name    = each.key
  type    = each.value.type
  records = each.value.records
  ttl     = each.value.ttl
}

data "aws_route53_zone" "zone_id" {
  name         = "spider-shlomo.com"
  private_zone = false
}