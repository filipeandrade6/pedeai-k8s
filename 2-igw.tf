resource "aws_internet_gateway" "k8svpc-igw" {
  vpc_id = aws_vpc.k8svpc.id

  tags = {
    Name = "k8svpc-igw"
  }

  depends_on = [ 
    aws_vpc.k8svpc
  ]

}