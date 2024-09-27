#---------------security_group-------------------#

# for vpc one 

resource "aws_security_group" "vpc_one_prod" {
  name   = "PROD"
  vpc_id = module.vpc["vpc-one"].vpc_id
  tags = {
    name = "SG"
  }

  ingress {
    description = "All traffic_in_80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks =  ["0.0.0.0/0"] 
  }

  ingress {
    description = "All traffic_in_80"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks =  ["10.10.0.0/16"] 
  }

  ingress {
    description = "All traffic_in_433"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks =  ["0.0.0.0/0"] 
  }

  ingress {
    description = "traffic in HTTP"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["84.228.161.67/32"] # access from any
  }

  egress {
    description = "All traffic_out"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# for vpc two

resource "aws_security_group" "vpc_two_lab" {
  name   = "LAB"
  vpc_id = module.vpc["vpc-two"].vpc_id
  tags = {
    name = "SGs"
  }

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks =  ["10.200.1.0/24","84.228.161.67/32"] # access from Home
  }

  egress {
    description = "All traffic_out"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}