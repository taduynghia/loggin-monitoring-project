resource "aws_vpc" "vpc-eks" {
  cidr_block = var.cidr_block
  tags = {
    "Name" = "vpc-eks"
  }
}
