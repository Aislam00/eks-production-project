output "cluster_id" {
  value = aws_eks_cluster.main.cluster_id
}

output "cluster_arn" {
  value = aws_eks_cluster.main.arn
}

output "cluster_name" {
  value = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.main.endpoint
}

output "cluster_version" {
  value = aws_eks_cluster.main.version
}

output "cluster_certificate_authority_data" {
  value = aws_eks_cluster.main.certificate_authority[0].data
}

output "cluster_security_group_id" {
  value = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
}

output "node_security_group_id" {
  value = aws_security_group.node_group.id
}

output "oidc_issuer_url" {
  value = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

output "cluster_iam_role_name" {
  value = aws_iam_role.cluster.name
}

output "cluster_iam_role_arn" {
  value = aws_iam_role.cluster.arn
}

output "node_groups" {
  value = aws_eks_node_group.main
}

output "aws_load_balancer_controller_role_arn" {
  value = aws_iam_role.aws_load_balancer_controller.arn
}

output "oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.cluster.arn
}