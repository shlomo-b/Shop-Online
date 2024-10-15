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
  type = map(object({
    tags        = map(string) # Tags to be applied to the security group
    vpc_key       = string      # VPC where the security group will be created
    description = string      # Description of the security group
    ingress_cidr_blocks = list(string)
    vpc_key     = string  
    ingress_with_cidr_blocks = map(object({
      from_port   = number         # Starting port for the rule
      to_port     = number         # Ending port for the rule
      protocol    = string         # Protocol (e.g., "tcp", "udp")
      description = string         # Rule description
      cidr_blocks = string  # CIDR blocks allowed to access
    }))
  }))
}