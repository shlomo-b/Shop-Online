module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name = "blackjack.spider-shlomo.com"
  validation_method = "DNS"
  zone_id     = "Z0728296NHGJUZD7IM32"   # Hosted zone ID of the domain spider-shlomo.com

#   subject_alternative_names = [
#     "app.spider-shlomo.com"
#   ]

  # create validation_record_fqdns in route53
  create_route53_records  = true
  validation_record_fqdns = [
    "_689571ee9a5f9ec307c512c5d851e25a.spider-shlomo.com",
  ]

  tags = {
    Name = "spider-shlomo.com"
 
  }
    # Add a delay after ACM creation
  depends_on = [null_resource.delay_acm]
}
# check if its runinin on linux or window
resource "null_resource" "delay_acm" {
  provisioner "local-exec" {
    command = <<-EOT
      if [ "$(uname -o)" = "GNU/Linux" ]; then
        sleep 60
      else
        powershell -Command Start-Sleep -Seconds 60
      fi
    EOT
  }
}



