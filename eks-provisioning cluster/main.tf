module "network" {
  source     = "./modules/network"
  cidr_block = "10.0.0.0/16"
  subnet_eks = ["10.0.1.0/24", "10.0.2.0/24"]
  zone       = ["us-west-2a", "us-west-2b"]
}

module "eks" {
  source         = "./modules/eks"
  instance_types = ["t2.small"]
  depends_on     = [module.network]
}