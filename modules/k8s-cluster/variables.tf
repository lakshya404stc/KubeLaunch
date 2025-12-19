variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "private_subnets" {
  description = "Map of private subnet IDs"
  type        = map(string)
}

variable "master_nodes" {
  description = "List of master node details"
  type = list(object({
    id                           = string
    private_ip                   = string
    primary_network_interface_id = string
  }))
}

variable "worker_nodes" {
  description = "List of worker node details"
  type = list(object({
    id                           = string
    private_ip                   = string
    primary_network_interface_id = string
  }))
}

variable "bastion_node" {
  description = "Bastion host details"
  type = object({
    public_ip                    = string
    primary_network_interface_id = string
  })
}

variable "ssh_user" {
  description = "SSH user for instances"
  type        = string
  default     = "ubuntu"
}

variable "private_key_path" {
  description = "Path to SSH private key"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version to install"
  type        = string
  default     = "1.28.0"
}

variable "pod_subnet_cidr" {
  description = "Pod network CIDR"
  type        = string
  default     = "192.168.0.0/16"
}

variable "service_subnet_cidr" {
  description = "Service network CIDR"
  type        = string
  default     = "10.96.0.0/12"
}

variable "cni_plugin" {
  description = "CNI plugin to install (calico, flannel, weave)"
  type        = string
  default     = "calico"
}

variable "bastion_allowed_cidrs" {
  description = "CIDR blocks allowed to SSH to bastion"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
