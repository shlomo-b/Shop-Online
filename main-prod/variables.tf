#---------------region-------------------#

variable "aws_region" {
  default = ["eu-central-1", "us-east-1"] # first: frankfurt , secound: virginia
  type    = list(string)
}

#---------------instance_type"-------------------#

variable "instance_type" {
  default = ["t3.2xlarge", "t2.small"]
  type    = list(string)
}

#---------------azs-------------------#

variable "azs" {
  default = ["us-east-1a","us-east-1b"]
 #  default = ["eu-central-1a", "eu-central-1b","us-east-1a","us-east-1b"]
  type    = list(string)
}

#---------------vpcs------------------#

variable "vpcs" {
  type = map(object({
    cidr            = string
    private_subnets = list(string)
    public_subnets  = list(string)
    azs             = list(string)
    tags            = map(string)
  }))
}


#---------------waf------------------#

# variable "waf" {
#   type = map(object({
#     name               = string
#     description        = string
#     scope              = optional(string)
#     ip_address_version = optional(string)
#     addresses          = optional(list(string))
#     priority           = number
#     action             = string
#     cloudwatch_metrics_enabled = bool
#     metric_name                = string
#     sampled_requests_enabled   = bool
#     ip_set_reference_statement = optional(object({
#       arn = string
#     }))
#   #  regex_string = optional(string)
#     regular_expression = optional(object({
#       regex_string = string
#    }))

#     regex_pattern_set_reference_statement = optional(object({
#       arn = string
#       field_to_match = object({
#            uri_path = string
#            priority = number
#            type  = string
#         })
#     }))
#   }))
# }

