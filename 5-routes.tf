# routing table
resource "aws_route_table" "private-a" {
  vpc_id = aws_vpc.k8svpc.id

  route {
      cidr_block                 = "0.0.0.0/0"
      nat_gateway_id             = aws_nat_gateway.k8s-nat1.id
    }

  tags = {
    Name = "private-a"
  }

  depends_on = [ aws_vpc.k8svpc, aws_nat_gateway.k8s-nat1 ]
}

resource "aws_route_table" "private-b" {
  vpc_id = aws_vpc.k8svpc.id

  route {
      cidr_block                 = "0.0.0.0/0"
      nat_gateway_id             = aws_nat_gateway.k8s-nat2.id
    }

  tags = {
    Name = "private-b"
  }

  depends_on = [ aws_vpc.k8svpc, aws_nat_gateway.k8s-nat2 ]
}

# TODO:"ver a necessidade de dois acima, pois no que segui so tinha 1"

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.k8svpc.id

  route {
      cidr_block                 = "0.0.0.0/0"
      gateway_id                 = aws_internet_gateway.k8svpc-igw.id
      nat_gateway_id             = null
      carrier_gateway_id         = null
      destination_prefix_list_id = null
      egress_only_gateway_id     = null
      local_gateway_id           = null
      network_interface_id       = null
      transit_gateway_id         = null
      vpc_endpoint_id            = null
      vpc_peering_connection_id  = null
      core_network_arn           = null
      ipv6_cidr_block            = null
    }

  tags = {
    Name = "public"
  }

  depends_on = [ aws_vpc.k8svpc, aws_internet_gateway.k8svpc-igw ]

}


# routing table association
# TODO: necessario separar em arquivo a parte o conteudo abaixo?

resource "aws_route_table_association" "private-us-east-1a" {
  subnet_id      = aws_subnet.private-us-east-1a.id
  route_table_id = aws_route_table.private-a.id
}

resource "aws_route_table_association" "private-us-east-1b" {
  subnet_id      = aws_subnet.private-us-east-1b.id
  route_table_id = aws_route_table.private-b.id
}

resource "aws_route_table_association" "public-us-east-1a" {
  subnet_id      = aws_subnet.public-us-east-1a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-us-east-1b" {
  subnet_id      = aws_subnet.public-us-east-1b.id
  route_table_id = aws_route_table.public.id
}