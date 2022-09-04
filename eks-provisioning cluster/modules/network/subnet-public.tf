resource "aws_subnet" "subnet-eks" {
  vpc_id                  = aws_vpc.vpc-eks.id
  cidr_block              = var.subnet_eks[count.index]
  availability_zone       = var.zone[count.index]
  map_public_ip_on_launch = true
  count                   = length(var.subnet_eks)
  tags = {
    "Name" = "subnet-eks-${count.index}"
  }
}
