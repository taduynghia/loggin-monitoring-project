resource "aws_security_group" "sg-k8s" {
  name        = "k8s"
  description = "allow all"
  vpc_id      = aws_vpc.vpc-eks.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "sg-k8s"
  }
}