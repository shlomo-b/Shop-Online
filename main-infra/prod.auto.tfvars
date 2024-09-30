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
  vpc-third = {
    cidr            = "10.30.0.0/16"
    private_subnets = ["10.30.1.0/24"] # "10.20.2.0/24", "10.200.3.0/24"]
    public_subnets  = ["10.30.100.0/25"] # "10.2.102.0/27"]
    azs             = ["us-east-1a","us-east-1b","us-east-1c"]
    tags = {
      name = "vpc-third"
    }
  }
}


sgs = {
    vpc-one = {
    vpc_name =  "vpc-one"
    cidr_block = "10.10.0.0/16"

    tags = {
      name = "vpc-one"
    }

    ingress = { 
      allow_port_80 = {
        description = "allow access port 80"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks =  ["0.0.0.0/0"]
      }
      allow_port_443 = {
        description = "allow access port 443"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks =  ["0.0.0.0/0"]
      }
      allow_from_my_ip_home = {
        description = "all_traffic_in_my_IP_and_my_vpc"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks =  ["84.228.161.67/32","10.10.0.0/16"]
      }
   }
  
    egress = {
      description = "All traffic_out"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
 }

  vpc-third = {
    vpc_name =  "vpc-third"
    cidr_block  = "10.30.0.0/16"

    tags = {
      name = "vpc-third"
    }
    ingress = { 
      allow_port_80 = {
        description = "allow access port 80"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks =  ["0.0.0.0/0"]
      }
    }
    egress = {
      description = "All traffic_out"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
 }
}