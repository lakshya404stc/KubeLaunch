variable "region" {
  type    = string
  default = "ap-south-1"
}

// module network
variable "vpc_name" {
  description = "Custom VPC name"
  type        = string
  default     = "k8s-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

// module compute
variable "key_name" {
  type = string
}

variable "nodes" {
  description = "List of nodes to create"
  type = list(object({
    workload      = string # master | worker
    instance_type = string
  }))
}

variable "bastion_instance_type" {
  type = string
}

variable "ami_id" {
  type = string
}

// Kubernetes Variables
variable "cluster_name" {
  description = "Kubernetes cluster name"
  type        = string
  default     = "prod-k8s"
}

variable "kubernetes_version" {
  description = "Kubernetes version"
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
  description = "CNI plugin (calico, flannel, weave)"
  type        = string
  default     = "calico"
  validation {
    condition     = contains(["calico", "flannel", "weave"], var.cni_plugin)
    error_message = "CNI plugin must be one of: calico, flannel, weave"
  }
}

// SSH Variables
variable "ssh_user" {
  description = "SSH username"
  type        = string
  default     = "ubuntu"
}

variable "private_key_path" {
  description = "Path to SSH private key"
  type        = string
}

variable "bastion_allowed_cidrs" {
  description = "CIDR blocks allowed to SSH to bastion"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

