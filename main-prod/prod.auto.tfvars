#---------------vpcs------------------#

vpcs = {
  vpc-one = {
    cidr            = "10.10.0.0/16"
    private_subnets = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
    public_subnets  = ["10.10.101.0/27", "10.10.102.0/27"]
  #  azs             = ["eu-central-1a", "eu-central-1b","us-east-1a","us-east-1b"]
    azs             = ["us-east-1a","us-east-1b"]
    tags = {
      name = "vpc-one"
    }
  }
  vpc-two = {
    cidr            = "10.20.0.0/16"
    private_subnets = ["10.20.1.0/24"] # "10.20.2.0/24", "10.200.3.0/24"]
    public_subnets  = ["10.20.100.0/27"] # "10.2.102.0/27"]
   #  azs             = ["eu-central-1a", "eu-central-1b","us-east-1a","us-east-1b"]
    azs             = ["us-east-1a","us-east-1b"]
    tags = {
      name = "vpc-two"
    }
  }
  vpc-third = {
    cidr            = "10.30.0.0/16"
    private_subnets = ["10.30.1.0/24"] # "10.20.2.0/24", "10.200.3.0/24"]
    public_subnets  = ["10.30.100.0/27"] # "10.2.102.0/27"]
   #  azs             = ["eu-central-1a", "eu-central-1b","us-east-1a","us-east-1b"]
    azs             = ["us-east-1a","us-east-1b"]
    tags = {
      name = "vpc-third"
    }
  }
}


# waf = {
#    rules = [
#     {
#       # rules
      
#       # rule 1
#       # this rule for allow access to app.
#       name     = "IpSetRule-0"
#       priority = "5"
#       action = "allow"

#         visibility_config = {
#         cloudwatch_metrics_enabled = true
#         metric_name                = "allow-specific-ip"
#         sampled_requests_enabled   = true
#         } 

#         # the arn of the ip
#         ip_set_reference_statement = {
#         arn = aws_wafv2_ip_set.allow_ips.arn 
#       }
#     }
#    ]
# }

