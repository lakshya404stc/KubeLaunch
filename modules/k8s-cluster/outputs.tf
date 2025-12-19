output "control_plane_endpoint" {
  description = "Kubernetes API server endpoint"
  value       = "https://${var.master_nodes[0].private_ip}:6443"
}

output "load_balancer_dns" {
  description = "Load balancer DNS name"
  value       = var.master_nodes[0].private_ip
}

output "kubeconfig_path" {
  description = "Path to generated kubeconfig file"
  value       = "${path.root}/kubeconfig-${var.cluster_name}.yaml"
}

output "master_security_group_id" {
  description = "Security group ID for master nodes"
  value       = aws_security_group.master.id
}

output "worker_security_group_id" {
  description = "Security group ID for worker nodes"
  value       = aws_security_group.worker.id
}

output "cluster_info" {
  description = "Cluster information summary"
  value = {
    cluster_name       = var.cluster_name
    api_endpoint       = "https://${var.master_nodes[0].private_ip}:6443"
    master_count       = length(var.master_nodes)
    worker_count       = length(var.worker_nodes)
    kubernetes_version = var.kubernetes_version
    cni_plugin         = var.cni_plugin
  }
}
