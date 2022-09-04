variable "cidr_block" {
  type = string
}

variable "subnet_eks" {
  type = list(any)
}

variable "zone" {
  type = list(any)
}