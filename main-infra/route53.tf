# resource "aws_route53_record" "spider-shlomo-com" {
#   zone_id = "Z0728296NHGJUZD7IM32"  # Hosted zone ID of the domain spider-shlomo.com
  
#   # send Delay untile the module acm will finish Delay of 60 sec
#  # depends_on = [module.acm, null_resource.delay_acm]
#   name    = "bshlomo.spider-shlomo.com"
#   type    = "A"
#   records = ["89.0.142.86"]
#   ttl     = 60
# }