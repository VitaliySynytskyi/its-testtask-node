module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.29.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_irsa = true

  eks_managed_node_groups = {
    general = {
      desired_size = 2
      min_size     = 2
      max_size     = 2

      labels = {
        role = "general"
      }

      instance_types = var.node_group_instance_types
      capacity_type  = "ON_DEMAND"
    }
  }

  manage_aws_auth_configmap = true

  node_security_group_additional_rules = {
    ingress_allow_access_from_control_plane = {
      type                          = "ingress"
      protocol                      = "tcp"
      from_port                     = 9443
      to_port                       = 9443
      source_cluster_security_group = true
      description                   = "Allow access from control plane to webhook port of AWS load balancer controller"
    }

    ingress_allow_efs = {
      type        = "ingress"
      protocol    = "tcp"
      from_port   = 2049
      to_port     = 2049
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow access from EFS security group"
    }
    egress_allow_efs = {
      type        = "egress"
      protocol    = "tcp"
      from_port   = 2049
      to_port     = 2049
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow egress to EFS security group"
    }

  }

  tags = var.staging_environment
}

data "aws_eks_cluster" "default" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "default" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  # token                  = data.aws_eks_cluster_auth.default.token

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.default.id]
    command     = "aws"
  }
}
