# aws node group 

resource "aws_eks_node_group" "private-nodes" {
  cluster_name    = aws_eks_cluster.demo.name
  node_group_name = "private-nodes"
  node_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/LabRole"

  subnet_ids = [
    aws_subnet.private-us-east-1a.id,
    aws_subnet.private-us-east-1b.id
  ]

  ami_type = "AL2_x86_64"
  capacity_type = "SPOT"
  disk_size = 20
  force_update_version = false

  instance_types = ["t3.small"]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  # update_config {
  #   max_unavailable = 1
  # }

  labels = {
    node = "kubenode02"
  }

  # taint {
  #   key    = "team"
  #   value  = "devops"
  #   effect = "NO_SCHEDULE"
  # }

  # launch_template {
  #   name    = aws_launch_template.eks-with-disks.name
  #   version = aws_launch_template.eks-with-disks.latest_version
  # }

  # depends_on = [
  #   aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
  #   aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
  #   aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
  # ]
}

# launch template if required

# resource "aws_launch_template" "eks-with-disks" {
#   name = "eks-with-disks"

#   key_name = "local-provisioner"

#   block_device_mappings {
#     device_name = "/dev/xvdb"

#     ebs {
#       volume_size = 50
#       volume_type = "gp2"
#     }
#   }
# }