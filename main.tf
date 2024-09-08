terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region_name
}

module "network" {
  source = "./modules/network"

  cluster_name = var.cluster_name
  region_name = var.region_name
  vpc_name = "${var.cluster_name}-vpc"
  igw_name = "${var.cluster_name}-public"

  private_subnet_name = "${var.cluster_name}-private"  
  public_subnet_name = "${var.cluster_name}-public"

  nat_name = "${var.cluster_name}-nat"
  eip_name = "${var.cluster_name}-eip"
}

module "eks" {
  source = "./modules/eks"

  cluster_name = var.cluster_name

  subnet_private-a_id = module.network.subnet_private-a_id
  subnet_private-b_id = module.network.subnet_private-b_id
  subnet_public-a_id = module.network.subnet_public-a_id
  subnet_public-b_id = module.network.subnet_public-b_id

  iam_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/LabRole"
}

module "workers_node_group" {
  source = "./modules/nodes"

  cluster_name = module.eks.eks_cluster_name
  subnet_private-a_id = module.network.subnet_private-a_id
  subnet_private-b_id = module.network.subnet_private-b_id

  iam_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/LabRole"
}

data "aws_caller_identity" "current" {}