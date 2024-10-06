# # Create an IAM role for the EKS cluster
# resource "aws_iam_role" "eks_cluster_role" {
#   name = "eks-cluster-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         # access to control plane of EKS to eks serivce | the conrole plane of the cluster its the service that manage the cluster
#         Effect = "Allow"
#         Principal = {
#           Service = "eks.amazonaws.com"
#         }
#         Action = "sts:AssumeRole"
#       },
#       { # aaccess to control plane of EC2 to eks serivce | the conrole plane of the cluster its the service that manage the cluster
#         Effect = "Allow"
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }


# # Attach the AdministratorAccess policy to the EKS cluster roles
# resource "aws_iam_role_policy_attachment" "eks_cluster_admin" {
#   role       = aws_iam_role.eks_cluster_role.name
#   policy_arn =  "arn:aws:iam::aws:policy/AdministratorAccess"

# }

# # Attach the AmazonEC2ContainerRegistryReadOnly policy to the EKS cluster role
# resource "aws_iam_role_policy_attachment" "eks_cluster_ec2" {
#   role       = aws_iam_role.eks_cluster_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

# }

# # Attach the AmazonEKS_CNI_Policy policy to the EKS cluster role
# resource "aws_iam_role_policy_attachment" "eks_cluster_eks_cni" {
#   role       = aws_iam_role.eks_cluster_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

# }

# # Attach the AmazonEKSWorkerNodePolicy policy to the EKS cluster role
# resource "aws_iam_role_policy_attachment" "eks_cluster_eks_worker" {
#   role       = aws_iam_role.eks_cluster_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

# }