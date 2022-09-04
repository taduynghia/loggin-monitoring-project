resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc-eks.id
}

resource "aws_route_table" "eks-tb" {
  vpc_id = aws_vpc.vpc-eks.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "association-sn" {
  route_table_id = aws_route_table.eks-tb.id
  subnet_id      = aws_subnet.subnet-eks[count.index].id
  count          = length(var.subnet_eks)
}