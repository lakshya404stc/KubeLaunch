variable "region" {
  description = "AWS region for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Custom VPC name"
  type        = string
  default = "k8s-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnet_cidr_blocks" {
  description = "List of CIDRs for private subnets per AZ (optional)"
  type        = list(string)
  default     = []
}

variable "public_subnet_cidr_blocks" {
  description = "List of CIDRs for public subnets per AZ (optional)"
  type        = list(string)
  default     = []
}
