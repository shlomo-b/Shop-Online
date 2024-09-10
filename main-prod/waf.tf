module "waf" {
  source = "umotif-public/waf-webaclv2/aws"
  version = "~> 5.0.0"

  name_prefix = "blackjack-waf"
  alb_arn     = module.alb.lb_arn # the arn of the alb 
  create_alb_association = true
  allow_default_action = false # block all the request https
  
  providers = {
    aws = aws.us-east
  }

   # it's for show the logs of allow or block
    visibility_config = {
    cloudwatch_metrics_enabled = true
    metric_name                = "blackjack-waf-logs"
    sampled_requests_enabled   = true
 }
 rules = [
    {
      # rules
      
      # rule 1
      # this rule for allow access to app.
      name     = "IpSetRule-0"
      priority = "5"
      action = "allow"

        visibility_config = {
        cloudwatch_metrics_enabled = true
        metric_name                = "allow-specific-ip"
        sampled_requests_enabled   = true
        } 

        # the arn of the ip
        ip_set_reference_statement = {
        arn = aws_wafv2_ip_set.allow_ips.arn 
      }
    },

    {
       # rule 2
       # this rule to block after the /
      name = "Block_after_slash"
      priority = "3"

      action = "block"

      visibility_config = {
        cloudwatch_metrics_enabled = true
        metric_name                = "RegexBadBotsUserAgent-metric"
        sampled_requests_enabled   = false
      }

      # You need to previously create you regex pattern
      # Refer to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_regex_pattern_set
      # for all of the options available.
      regex_pattern_set_reference_statement = {
       # url_path = {}
        # the arn of the regex
        arn       = aws_wafv2_regex_pattern_set.block_wildcard.arn
        field_to_match = {
          uri_path = "{}"
        }
        priority  = 3
        type      = "LOWERCASE" # The text transformation type
      }
    },

    {
       # rule 3
       # allow /presentation
      name = "allow_presentation"
      priority = "0"

      action = "allow"

      visibility_config = {
        cloudwatch_metrics_enabled = true
        metric_name                = "RegexBadBotsUserAgent-metric"
        sampled_requests_enabled   = false
      }

      # You need to previously create you regex pattern
      # Refer to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_regex_pattern_set
      # for all of the options available.
      regex_pattern_set_reference_statement = {
       # url_path = {}
        # the arn of the regex
        arn       = aws_wafv2_regex_pattern_set.presentation.arn
        field_to_match = {
          uri_path = "{}"
        }
        priority  = 0
        type      = "LOWERCASE" # The text transformation type
      }
    },
    
    {
       # rule 4
       # allow /metrics for prometheus
      name = "allow_metrics_for_prometheus"
      priority = "1"

      action = "allow"

      visibility_config = {
        cloudwatch_metrics_enabled = true
        metric_name                = "RegexBadBotsUserAgent-metric"
        sampled_requests_enabled   = true
      }

      # You need to previously create you regex pattern
      # Refer to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_regex_pattern_set
      # for all of the options available.
      regex_pattern_set_reference_statement = {
       # url_path = {}
        # the arn of the regex
        arn       = aws_wafv2_regex_pattern_set.allow_metrics.arn
        field_to_match = {
          uri_path = "{}"
        }
        priority  = 1
        type      = "LOWERCASE" # The text transformation type
      }
    }
 ]
}



# the region when the ALB exsit 
provider "aws" {
  alias = "us-east"
  region  = "us-east-1"
}

# ipsets allow only my ip
resource "aws_wafv2_ip_set" "allow_ips" {
  name               = "shlomo-home"
  description        = "IPset"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = ["84.228.161.67/32"]
}


# creare regex to block after the / 
resource "aws_wafv2_regex_pattern_set" "block_wildcard" {
  name        = "block_all_after_slash"
  scope       = "REGIONAL"
  
  regular_expression {
    # block all after the / 
    regex_string = "^/.+"
  }
}


# creare regex to allow after /presentation
resource "aws_wafv2_regex_pattern_set" "presentation" {
  name        = "allow_presentation"
  scope       = "REGIONAL"
  
  regular_expression {
    # allow /admin-shlomo 
    regex_string = "^/presentation+"
  }
}

# creares regex to allow after /metrics
resource "aws_wafv2_regex_pattern_set" "allow_metrics" {
  name        = "allow_metrics"
  scope       = "REGIONAL"
  
  regular_expression {
    # allow /admin-shlomo 
    regex_string = "^/metrics+"
  }
}