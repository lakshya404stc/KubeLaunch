variable "public_subnets" {
  type = map(string) # az => subnet_id
}

variable "private_subnets" {
  type = map(string) # az => subnet_id
}

variable "nodes" {
  description = "List of nodes to create"
  type = list(object({
    workload       = string # master | worker
    instance_type  = string
  }))
}

variable "bastion_instance_type" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "key_name" {
  type = string
}
