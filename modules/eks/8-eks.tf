resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.cluster_name}-eks-cluster"
  role_arn = var.iam_role_arn

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access = true

    subnet_ids = [
      var.subnet_private-a_id,
      var.subnet_private-b_id,
      var.subnet_public-a_id,
      var.subnet_public-b_id
    ]
  }
  
}