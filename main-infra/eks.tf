module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "my-cluster"
  cluster_version = "1.30"
  cluster_service_ipv4_cidr = "10.200.0.0/16"
  cluster_endpoint_public_access  = true
  cluster_endpoint_public_access_cidrs = ["84.228.161.67/32"]

  # Disable creation of security groups
  create_cluster_security_group = false
  create_node_security_group    = false
  cluster_security_group_id = aws_security_group.sgs["vpc-one"].id
  
  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }
  
    vpc_id                   =  module.vpc["vpc-one"].vpc_id
    subnet_ids               = [
        module.vpc["vpc-one"].public_subnets[0],
        module.vpc["vpc-one"].public_subnets[1]
    ]
    control_plane_subnet_ids = [
        module.vpc["vpc-one"].private_subnets[0],
        module.vpc["vpc-one"].private_subnets[1]
    ]
    
    # create_iam_role = false
    # iam_role_name = "eks-cluster-role"
    # iam_role_arn = "arn:aws:iam::148088962203:role/eks-cluster-role"

  # EKS Managed Node Group(s) 
  eks_managed_node_group_defaults = {
    instance_types = ["t3.medium"]

    # create self iam role and give access to node group
    create_iam_role = false
    iam_role_name = "eks-cluster-role"
    iam_role_arn = "arn:aws:iam::148088962203:role/eks-cluster-role"
    
  }

  eks_managed_node_groups = {
    blackjack_k8s = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 5
      desired_size = 1
      vpc_security_group_ids = [aws_security_group.sgs["vpc-one"].id]
      key_name = "TF-key"
    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true

  access_entries = {
    # One access entry with a policy associated
    permissions = {
      kubernetes_groups = []
      principal_arn     = "arn:aws:iam::148088962203:user/shlomob" # add user to access to my cluster

      policy_associations = {
        example = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy" # give the user shlomob access to the cluster
          access_scope = {
            namespaces = []
            type       = "cluster" # the type of the cluster
          }
        }
      }
    }
  }
   
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

