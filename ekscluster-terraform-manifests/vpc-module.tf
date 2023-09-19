# AWS Availability Zones Datasource
data "aws_availability_zones" "available" {
  filter {
    name   = "zone-name"
    values = ["us-east-1a", "us-east-1b"]
  }
}

# Create VPC Terraform Module
module "vpc" {
  source  = "registry.terraform.io/terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  # VPC Basic Details
  name           = local.eks_cluster_name
  cidr           = var.vpc_cidr_block
  azs            = data.aws_availability_zones.available.names
  public_subnets = var.vpc_public_subnets

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags     = local.common_tags
  vpc_tags = local.common_tags

  # Additional Tags to Subnets
  public_subnet_tags = {
    Type                                              = "Public Subnets"
    "kubernetes.io/role/elb"                          = 1
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
  }

  # Instances launched into the Public subnet should be assigned a public IP address.
  map_public_ip_on_launch = true
}