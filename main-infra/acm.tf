module "acm" {
  for_each = var.acm

  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name = each.key
  validation_method = "DNS"
  zone_id     = data.aws_route53_zone.zone_id.zone_id   # Hosted zone ID of the domain spider-shlomo.com

  # create validation_record_fqdns in route53
  create_route53_records  = true
  validation_record_fqdns = [
    "_689571ee9a5f9ec307c512c5d851e25a.spider-shlomo.com",
  ]
  wait_for_validation = true
}