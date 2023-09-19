# Define Local Values in Terraform
locals {
  owners      = var.owner
  environment = var.environment
  name        = "${var.owner}-${var.environment}"
  host_port = 80
  container_port = 3000
  #name = "${local.owners}-${local.environment}"
  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
  eks_cluster_name = "${local.name}-${var.cluster_name}"
} 