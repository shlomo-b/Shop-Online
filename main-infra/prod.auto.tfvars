#---------------vpcs------------------#

vpcs = {
  vpc-one = {
    cidr            = "10.10.0.0/16"
    private_subnets = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
    public_subnets  = ["10.10.101.0/25", "10.10.102.0/25"]
    azs             = ["us-east-1a","us-east-1b","us-east-1c"]
    tags = {
      name = "vpc-one"
    }
  }
  vpc-two = {
    cidr            = "10.20.0.0/16"
    private_subnets = ["10.20.1.0/24"] # "10.20.2.0/24", "10.200.3.0/24"]
    public_subnets  = ["10.20.100.0/25"] # "10.2.102.0/27"]
    azs             = ["us-east-1a","us-east-1b","us-east-1c"]
    tags = {
      name = "vpc-two"
    }
  }
  # vpc-third = {
  #   cidr            = "10.30.0.0/16"
  #   private_subnets = ["10.30.1.0/24"] # "10.20.2.0/24", "10.200.3.0/24"]
  #   public_subnets  = ["10.30.100.0/25"] # "10.2.102.0/27"]
  #   azs             = ["us-east-1a","us-east-1b","us-east-1c"]
  #   tags = {
  #     name = "vpc-third"
  #   }
  # }
}

sgs = {
  vpc-one = {
    vpc_key     = "vpc-one"  # This will be used to lookup the VPC ID
    description = "vpc-one"
  
  tags = {
      name = "vpc-one"
    }
   ingress_cidr_blocks = ["10.10.0.0/16"] # Use the CIDR of vpc-third
    ingress_with_cidr_blocks = {
        all_traffic_my_home = {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          description = "all"
          cidr_blocks = "10.10.0.0/16"
        },
        all_traffic_vpc = {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          description = "all"
          cidr_blocks = "84.228.161.67/32"
        }
  }  
  }

  vpc-two = {
    vpc_key    = "vpc-two"  # This will be used to lookup the VPC ID
    description = "vpc-two"

    tags = {
      name = "vpc-two"
    }

    ingress_cidr_blocks = ["10.30.0.0/16"] # Use the CIDR of vpc-third
    ingress_with_cidr_blocks = {
      allow_port_80 = {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          description = "Allow HTTP"
          cidr_blocks = "0.0.0.0/0"
        },
        allow_port_90 = {
          from_port   = 90
          to_port     = 90
          protocol    = "tcp"
          description = "Allow HTTP"
          cidr_blocks = "0.0.0.0/0"
        }
  }
 }
}
