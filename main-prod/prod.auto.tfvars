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
#   rule1 = {
#     name               = "IpSetRule-0"
#     description        = "Allow specific IPs"
#     scope              = "REGIONAL"
#     ip_address_version = "IPV4"
#     addresses          = ["84.228.161.67/32", "84.95.239.232/29"]
#     priority           = 5
#     action             = "allow"
#     cloudwatch_metrics_enabled = true
#     metric_name                = "allow-specific-ip"
#     sampled_requests_enabled   = true
#     ip_set_reference_statement = {
#       arn = "ip_set_reference_statement"
#   },
#   }
#   rule2 = {
#     name               = "Block_after_slash"
#     description        = "allow_presentation"
#     scope              = "REGIONAL"
#     priority           = 0
#     ip_address_version = "IPV4"
#     action             = "allow"
#     cloudwatch_metrics_enabled = true
#     metric_name                = "presentation"
#     sampled_requests_enabled   = true
#     regular_expression = {
#       regex_string = "^/presentation+"
#      }
#     regex_pattern_set_reference_statement = {
#       arn = "regex_pattern_set_reference_statement"
#           field_to_match = {
#            uri_path = "{}"
#            priority = 0
#            type  = "LOWERCASE"
#       }
#     }
#   }
# }

 