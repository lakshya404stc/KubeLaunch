module "vpc" {
  source = "../../modules/network"

  region                      = var.region
  vpc_cidr                    = var.vpc_cidr
  vpc_name                    = var.vpc_name
  public_subnet_cidr_blocks   = []
  private_subnet_cidr_blocks  = []
}

module "ec2" {
  source = "../../modules/compute"

  ami_id                = var.ami_id
  bastion_instance_type = var.bastion_instance_type
  key_name              = var.key_name
  public_subnets        = module.vpc.public_subnets
  private_subnets       = module.vpc.private_subnets
  nodes                 = var.nodes

  depends_on = [module.vpc]
}

module "k8s_cluster" {
  source = "../../modules/k8s-cluster"

  cluster_name       = var.cluster_name
  vpc_id             = module.vpc.vpc_id
  vpc_cidr           = var.vpc_cidr
  private_subnets    = module.vpc.private_subnets
  
  master_nodes = [
    for node in module.ec2.master_nodes : {
      id                           = node.id
      private_ip                   = node.private_ip
      primary_network_interface_id = node.primary_network_interface_id
    }
  ]

  worker_nodes = [
    for node in module.ec2.worker_nodes : {
      id                           = node.id
      private_ip                   = node.private_ip
      primary_network_interface_id = node.primary_network_interface_id
    }
  ]

  bastion_node = {
    public_ip                    = module.ec2.bastion.public_ip
    primary_network_interface_id = module.ec2.bastion.primary_network_interface_id
  }

  ssh_user            = var.ssh_user
  private_key_path    = var.private_key_path
  kubernetes_version  = var.kubernetes_version
  pod_subnet_cidr     = var.pod_subnet_cidr
  service_subnet_cidr = var.service_subnet_cidr
  cni_plugin          = var.cni_plugin
  bastion_allowed_cidrs = var.bastion_allowed_cidrs

  depends_on = [module.ec2]
}
