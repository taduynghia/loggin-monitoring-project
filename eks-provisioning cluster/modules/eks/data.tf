data "aws_subnet" "eks-subnet" {
  filter {
    name   = "tag:Name"
    values = ["subnet-eks-${count.index}"]
  }
  count = 2
}

data "aws_security_group" "sg-k8s" {
  filter {
    name   = "tag:Name"
    values = ["sg-k8s"]
  }
}