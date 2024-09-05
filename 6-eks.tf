# bare minimum requirement of eks

resource "aws_eks_cluster" "demo" {
  name     = "demo"
  role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/LabRole"

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access = true

    subnet_ids = [
      aws_subnet.private-us-east-1a.id,
      aws_subnet.private-us-east-1b.id,
      aws_subnet.public-us-east-1a.id,
      aws_subnet.public-us-east-1b.id
    ]
  }
  
}

data "aws_caller_identity" "current" {}