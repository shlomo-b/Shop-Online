module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "my-cluster"
  cluster_version = "1.31"
  cluster_service_ipv4_cidr = "10.200.0.0/16"
  cluster_endpoint_public_access  = true
#  cluster_endpoint_public_access_cidrs = ["84.228.161.67/32"]

  # Disable creation of security groups
  create_cluster_security_group = false
  create_node_security_group    = false
  cluster_security_group_id = module.sgs["vpc-one"].security_group_id
  
  cluster_addons = {
    coredns                = {} # coredns its for manage the dns server
    eks-pod-identity-agent = {} # eks-pod-identity-agent its for manage the pod identity
    kube-proxy             = {} # kube-proxy its for manage the kube-proxy
    vpc-cni                = {} # vpc cni its for manage the network and associate IPs to pods
    aws-ebs-csi-driver     = {} # aws ebs csi driver its for manage the ebs csi driver
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
    
  # EKS Managed Node Group(s) 
  eks_managed_node_group_defaults = {
    instance_types = ["m5.large"]

    # create self iam role and give access to node group
    create_iam_role = false
    iam_role_name =  aws_iam_role.eks_cluster_role.name
    iam_role_arn  =  aws_iam_role.eks_cluster_role.arn
  }

  eks_managed_node_groups = {
    blackjack_k8s = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["m5.large"]

      min_size     = 1
      max_size     = 5
      desired_size = 1
      vpc_security_group_ids = [module.sgs["vpc-one"].security_group_id]
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
