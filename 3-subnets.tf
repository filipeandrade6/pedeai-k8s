# private subnet 01

resource "aws_subnet" "private-us-east-1a" {
  vpc_id            = aws_vpc.k8svpc.id
  cidr_block        = "192.168.0.0/19"
  availability_zone = "us-east-1a"

  tags = {
    Name                              = "private-us-east-1a"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
    # "kubernetes.io/cluster/${var.cluster_name}-eks-cluster" = "shared"
  }

  depends_on = [ aws_vpc.k8svpc ]
}
# private subnet 02

resource "aws_subnet" "private-us-east-1b" {
  vpc_id            = aws_vpc.k8svpc.id
  cidr_block        = "192.168.32.0/19"
  availability_zone = "us-east-1b"

  tags = {
    Name                              = "private-us-east-1b"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
    # "kubernetes.io/cluster/${var.cluster_name}-eks-cluster" = "shared"
  }

  depends_on = [ aws_vpc.k8svpc ]
}

# public subnet 01

resource "aws_subnet" "public-us-east-1a" {
  vpc_id                  = aws_vpc.k8svpc.id
  cidr_block              = "192.168.64.0/19"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name                         = "public-us-east-1a"
    "kubernetes.io/role/elb"     = "1" #this instruct the kubernetes to create public load balancer in these subnets
    "kubernetes.io/cluster/demo" = "owned"
    # "kubernetes.io/cluster/${var.cluster_name}-eks-cluster" = "shared"
  }

  depends_on = [ aws_vpc.k8svpc ]
}
# public subnet 02

resource "aws_subnet" "public-us-east-1b" {
  vpc_id                  = aws_vpc.k8svpc.id
  cidr_block              = "192.168.96.0/19"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name                         = "public-us-east-1b"
    "kubernetes.io/role/elb"     = "1" #this instruct the kubernetes to create public load balancer in these subnets
    "kubernetes.io/cluster/demo" = "owned"
    # "kubernetes.io/cluster/${var.cluster_name}-eks-cluster" = "shared"
  }

  depends_on = [ aws_vpc.k8svpc ]
}