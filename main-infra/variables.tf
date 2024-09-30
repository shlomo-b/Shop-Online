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

#---------------sgs------------------#

variable "sgs" {
  type = map(object({       # contains the values ​​below it
    tags            = map(string)
    vpc_name = string


    ingress = map(object({ 
      description = string
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))

    egress = object({
      description = string
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    })
  }))
}
