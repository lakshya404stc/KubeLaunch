# output "vpc_id" {
#   description = "VPC ID"
#   value       = module.vpc.vpc_id
# }

# output "public_subnets" {
#   description = "Public subnet IDs"
#   value       = module.vpc.public_subnets
# }

# output "private_subnets" {
#   description = "Private subnet IDs"
#   value       = module.vpc.private_subnets
# }

# output "bastion_instance_id" {
#   description = "Bastion host instance ID"
#   value       = module.ec2.bastion_instance_id
# }

# output "master_instance_ids" {
#   description = "Master node instance IDs"
#   value       = module.ec2.master_instance_ids
# }

# output "worker_instance_ids" {
#   description = "Worker node instance IDs"
#   value       = module.ec2.worker_instance_ids
# }

# output "node_private_ips" {
#   description = "Private IPs of all nodes"
#   value       = module.ec2.node_private_ips
# }

# output "test_summary" {
#   description = "Test deployment summary"
#   value = {
#     vpc_id              = module.vpc.vpc_id
#     public_subnet_count = length(module.vpc.public_subnets)
#     private_subnet_count = length(module.vpc.private_subnets)
#     bastion_id          = module.ec2.bastion_instance_id
#     master_count        = length(module.ec2.master_instance_ids)
#     worker_count        = length(module.ec2.worker_instance_ids)
#     total_nodes         = length(module.ec2.node_private_ips)
#   }
# }

output "bastion" {
  description = "Bastion host details"
  value       = module.ec2.bastion
  sensitive   = false
}

output "master_nodes" {
  description = "Master node details"
  value       = module.ec2.master_nodes
}

output "worker_nodes" {
  description = "Worker node details"
  value       = module.ec2.worker_nodes
}

output "kubernetes_api_endpoint" {
  description = "Kubernetes API server endpoint"
  value       = module.k8s_cluster.control_plane_endpoint
}

output "kubeconfig_path" {
  description = "Path to kubeconfig file"
  value       = module.k8s_cluster.kubeconfig_path
}

output "cluster_info" {
  description = "Complete cluster information"
  value       = module.k8s_cluster.cluster_info
}

output "deployment_summary" {
  description = "Complete deployment summary"
  value = {
    vpc = {
      id              = module.vpc.vpc_id
      cidr            = var.vpc_cidr
      public_subnets  = length(module.vpc.public_subnets)
      private_subnets = length(module.vpc.private_subnets)
    }
    compute = {
      bastion_ip   = module.ec2.bastion.public_ip
      master_count = length(module.ec2.master_nodes)
      worker_count = length(module.ec2.worker_nodes)
    }
    kubernetes = {
      cluster_name = var.cluster_name
      api_endpoint = module.k8s_cluster.control_plane_endpoint
      version      = var.kubernetes_version
      cni_plugin   = var.cni_plugin
    }
  }
}
