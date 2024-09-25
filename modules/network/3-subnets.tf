# private subnet 1
resource "aws_subnet" "private-a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name                              = "${var.private_subnet_name}-${var.region_name}a"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/${var.cluster_name}-eks-cluster"      = "shared"
  }

  depends_on = [ aws_vpc.vpc ]
}

# private subnet 2
resource "aws_subnet" "private-b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.32.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name                              = "${var.private_subnet_name}-${var.region_name}b"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/${var.cluster_name}-eks-cluster" = "shared"
  }

  depends_on = [ aws_vpc.vpc ]
}

# public subnet 1
resource "aws_subnet" "public-a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.64.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name                         = "${var.public_subnet_name}-${var.region_name}a"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/${var.cluster_name}-eks-cluster" = "shared"
  }

  depends_on = [ aws_vpc.vpc ]
}

# public subnet 2
resource "aws_subnet" "public-b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.96.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name                         = "${var.public_subnet_name}-${var.region_name}b"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/${var.cluster_name}-eks-cluster" = "shared"
  }

  depends_on = [ aws_vpc.vpc ]
}