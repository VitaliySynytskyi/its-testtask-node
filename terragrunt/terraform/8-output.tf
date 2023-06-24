output "repository_url" {
  description = "URL of the created ECR repository"
  value       = aws_ecr_repository.repository.repository_url
}

output "efs_id" {
  description = "The ID of the EFS file system"
  value       = aws_efs_file_system.efs.id
}

output "ecr_repository_name" {
  description = "Name of the ECR repository"
  value       = aws_ecr_repository.repository.name
}

output "ecr_repository_registry_id" {
  description = "Registry ID of the ECR repository"
  value       = aws_ecr_repository.repository.registry_id
}

output "eks_cluster_name" {
  description = "Cluster ID of the EKS cluster"
  value       = module.eks.cluster_id
}

output "certificate_arn" {
  description = "ARN of the ACM certificate"
  value       = aws_acm_certificate.cert.arn
}
