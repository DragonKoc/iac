data "aws_eks_cluster" "cluster" {
  name = module.my-cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.my-cluster.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.9"
}

module "my-cluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "Itea-eks"
  cluster_version = "1.18"
  subnets         = [aws_subnet.itea-subnet-public-1.id, aws_subnet.itea-subnet-public-2.id]
  vpc_id          = aws_vpc.itea-vpc.id

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.micro"
      asg_desired_capacity          = 2
      root_volume_type = "gp2"
      additional_security_group_ids = [aws_security_group.itea-all.id]
    },
    {
      name                          = "worker-group-2"
      instance_type                 = "t2.micro"
      root_volume_type = "gp2"
      additional_security_group_ids = [aws_security_group.itea-all.id]
      asg_desired_capacity          = 1
    },
  ]
}