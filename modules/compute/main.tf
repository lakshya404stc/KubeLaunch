locals {
  public_subnet_ids  = values(var.public_subnets)
  private_subnet_ids = values(var.private_subnets)
}

resource "aws_instance" "bastion" {
  ami           = var.ami_id
  instance_type = var.bastion_instance_type
  subnet_id     = local.public_subnet_ids[0]
  key_name      = var.key_name

  tags = {
    Name = "bastion"
    Role = "bastion"
  }
}

resource "aws_instance" "nodes" {
  count = length(var.nodes)

  ami           = var.ami_id
  instance_type = var.nodes[count.index].instance_type

  subnet_id = local.private_subnet_ids[
    count.index % length(local.private_subnet_ids)
  ]

  key_name = var.key_name

  tags = {
    Name = "${var.nodes[count.index].workload}-${count.index}"
    Role = var.nodes[count.index].workload
  }
}
