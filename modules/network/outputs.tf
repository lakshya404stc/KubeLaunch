output "vpc_id" {
  value = aws_vpc.this.id
}

output "private_subnets" {
  value = { for k, v in aws_subnet.private : k => v.id }
}

output "public_subnets" {
  value = { for k, v in aws_subnet.public : k => v.id }
}
