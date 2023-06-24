variable "name" {
  description = "The name of the VPC"
  type        = string
  default     = "main"
}

variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "List of Availability Zones to be used"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "private_subnets" {
  description = "List of private subnets"
  type        = list(string)
  default     = ["10.0.0.0/19", "10.0.32.0/19"]
}

variable "public_subnets" {
  description = "List of public subnets"
  type        = list(string)
  default     = ["10.0.64.0/19", "10.0.96.0/19"]
}

variable "staging_environment" {
  description = "Environment tag"
  type        = map(string)
  default     = { Environment = "staging" }
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "my-eks"
}

variable "cluster_version" {
  description = "The Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.23"
}

variable "node_group_instance_types" {
  description = "The instance types to use for the node groups"
  type        = list(string)
  default     = ["t3.small"]
}

variable "helm_aws_lb_controller_version" {
  description = "The version of the AWS Load Balancer Controller chart"
  type        = string
  default     = "1.4.4"
}

variable "aws_lb_controller_replica_count" {
  description = "The number of replicas of the AWS Load Balancer Controller"
  type        = number
  default     = 2
}

variable "aws_lb_controller_role_name" {
  description = "The name of the IAM role for the AWS Load Balancer Controller"
  type        = string
  default     = "aws-load-balancer-controller"
}

variable "ecr_repository_name" {
  description = "The name of the ECR repository"
  type        = string
  default     = "my-app-repo"
}

variable "ecr_image_tag_mutability" {
  description = "The tag mutability setting for the ECR repository"
  type        = string
  default     = "MUTABLE"
}

variable "ecr_scan_on_push" {
  description = "Indicates whether images are scanned on push"
  type        = bool
  default     = true
}

variable "efs_creation_token" {
  description = "An unique name used as reference when creating EFS"
  type        = string
  default     = "my-efs"
}

variable "efs_name_tag" {
  description = "Name tag for EFS"
  type        = string
  default     = "my_efs"
}

variable "efs_sg_name" {
  description = "Name for EFS security group"
  type        = string
  default     = "efs_sg"
}

variable "efs_sg_description" {
  description = "Description for EFS security group"
  type        = string
  default     = "Allow NFS traffic for EFS"
}

variable "efs_policy_name" {
  description = "Name for the EFS access policy"
  type        = string
  default     = "efs_access_policy"
}

variable "domain_name" {
  description = "The domain name for which the certificate should be issued"
  type        = string
  default     = "sample-django.pp.ua"
}



