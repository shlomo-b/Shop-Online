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

