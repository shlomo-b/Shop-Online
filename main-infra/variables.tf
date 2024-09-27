#---------------region-------------------#

variable "aws_region" {
  default = ["eu-central-1", "us-east-1"] # first: frankfurt , secound: virginia
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