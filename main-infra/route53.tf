# resource "aws_route53_record" "spider-shlomo-com" {
#   zone_id = "Z0728296NHGJUZD7IM32"  # Hosted zone ID of the domain spider-shlomo.com
  
#   # send Delay untile the module acm will finish Delay of 60 sec
#   depends_on = [module.acm, null_resource.delay_acm]
#   name    = "blackjack.spider-shlomo.com"
#   type    = "A"
#   alias {
#     name                   = module.alb.lb_dns_name # dns name of the alb
#     zone_id                = "Z0728296NHGJUZD7IM32" # The hosted zone ID of the load balancer
#     evaluate_target_health = true  # Set to true if you want Route 53 to evaluate the health of the target
#   }
# }

