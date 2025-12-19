output "bastion" {
  value = {
    id         = aws_instance.bastion.id
    public_ip  = aws_instance.bastion.public_ip
    private_ip = aws_instance.bastion.private_ip
    primary_network_interface_id = aws_instance.bastion.primary_network_interface_id
  }
}

output "master_nodes" {
  value = [
    for i, n in aws_instance.nodes : {
      id         = n.id
      private_ip = n.private_ip
      az         = n.availability_zone
      primary_network_interface_id = n.primary_network_interface_id
    }
    if var.nodes[i].workload == "master"
  ]
}

output "worker_nodes" {
  value = [
    for i, n in aws_instance.nodes : {
      id         = n.id
      private_ip = n.private_ip
      az         = n.availability_zone
      primary_network_interface_id = n.primary_network_interface_id
    }
    if var.nodes[i].workload == "worker"
  ]
}
