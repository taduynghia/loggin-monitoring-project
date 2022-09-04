resource "aws_eks_cluster" "k8s-cluster" {
  name     = "k8s"
  role_arn = aws_iam_role.k8s-cluster.arn
  vpc_config {
    subnet_ids         = [data.aws_subnet.eks-subnet[0].id, data.aws_subnet.eks-subnet[1].id]
    security_group_ids = [data.aws_security_group.sg-k8s.id]
  }
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy
  ]
}

resource "aws_eks_node_group" "k8s-node" {
  node_group_name = "node-worker"
  cluster_name    = aws_eks_cluster.k8s-cluster.name
  node_role_arn   = aws_iam_role.k8s-node.arn
  subnet_ids      = data.aws_subnet.eks-subnet[*].id
  instance_types  = var.instance_types
  capacity_type   = "ON_DEMAND"
  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }
  update_config {
    max_unavailable = 1
  }
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly
  ]
}