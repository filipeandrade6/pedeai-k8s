
# separar em eip em outros arquivos

resource "aws_eip" "eip1" {
  domain = "vpc"

  tags = {
    Name = "eip1-a"
  }

  depends_on = [ aws_internet_gateway.k8svpc-igw ]

}

resource "aws_eip" "eip2" {
  domain = "vpc"

  tags = {
    Name = "eip1-b"
  }

  depends_on = [ aws_internet_gateway.k8svpc-igw ]

}


# resource "aws_eip" "nat" {
#   vpc = true

#   tags = {
#     Name = "nat"
#   }
# }


# ver a necessidade de dois, no exemplo que segui so tinha 1

resource "aws_nat_gateway" "k8s-nat1" {
  allocation_id = aws_eip.eip1.id
  subnet_id     = aws_subnet.public-us-east-1a.id

  tags = {
    Name = "k8s-nat-1"
  }

  depends_on = [aws_internet_gateway.k8svpc-igw]
}

resource "aws_nat_gateway" "k8s-nat2" {
  allocation_id = aws_eip.eip2.id
  subnet_id     = aws_subnet.public-us-east-1b.id

  tags = {
    Name = "k8s-nat-2"
  }

  depends_on = [aws_internet_gateway.k8svpc-igw]
}