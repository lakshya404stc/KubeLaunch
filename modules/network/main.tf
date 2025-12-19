provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "k8s-igw"
  }
}

resource "aws_subnet" "public" {
  for_each = toset(data.aws_availability_zones.available.names)
  vpc_id            = aws_vpc.this.id
  availability_zone = each.key
  cidr_block        = length(var.public_subnet_cidr_blocks) > 0 ? var.public_subnet_cidr_blocks[index(data.aws_availability_zones.available.names, each.key)] : cidrsubnet(var.vpc_cidr, 8, index(data.aws_availability_zones.available.names, each.key))
  map_public_ip_on_launch = true

  tags = {
    Name = "public-${each.key}"
  }
}

resource "aws_subnet" "private" {
  for_each = toset(data.aws_availability_zones.available.names)
  vpc_id            = aws_vpc.this.id
  availability_zone = each.key
  cidr_block        = length(var.private_subnet_cidr_blocks) > 0 ? var.private_subnet_cidr_blocks[index(data.aws_availability_zones.available.names, each.key)] : cidrsubnet(var.vpc_cidr, 8, 100 + index(data.aws_availability_zones.available.names, each.key))
  map_public_ip_on_launch = false

  tags = {
    Name = "private-${each.key}"
  }
}

resource "aws_eip" "nat" {
  # vpc argument not supported
  # will automatically attach to NAT gateway in EC2-VPC
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = values(aws_subnet.public)[0].id

  tags = {
    Name = "nat-single"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  for_each = aws_subnet.private
  vpc_id   = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = {
    Name = "private-rt-${each.key}"
  }
}

resource "aws_route_table_association" "private_assoc" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}
