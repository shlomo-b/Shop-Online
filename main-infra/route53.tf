resource "aws_route53_record" "spider-shlomo-com" {
  for_each = var.route53
  
  zone_id = "Z0728296NHGJUZD7IM32"  # Hosted zone ID of the domain spider-shlomo.com
  name    = each.key
  type    = each.value.type
  records = each.value.records
  ttl     = each.value.ttl
}