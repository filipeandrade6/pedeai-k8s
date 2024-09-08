resource "aws_route_table" "private-a" {
  vpc_id = aws_vpc.vpc.id

  route {
      cidr_block                 = "0.0.0.0/0"
      nat_gateway_id             = aws_nat_gateway.nat1.id
    }

  tags = {
    Name = "rt-private-a"
  }

  depends_on = [ aws_vpc.vpc, aws_nat_gateway.nat1 ]
}

resource "aws_route_table" "private-b" {
  vpc_id = aws_vpc.vpc.id

  route {
      cidr_block                 = "0.0.0.0/0"
      nat_gateway_id             = aws_nat_gateway.nat2.id
    }

  tags = {
    Name = "rt-private-b"
  }

  depends_on = [ aws_vpc.vpc, aws_nat_gateway.nat2 ]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
      cidr_block                 = "0.0.0.0/0"
      gateway_id                 = aws_internet_gateway.igw.id
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
    Name = "rt-public"
  }

  depends_on = [ aws_vpc.vpc, aws_internet_gateway.igw ]
}