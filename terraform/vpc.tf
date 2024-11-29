module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.16.0"

  name = var.vpc_name
  azs  = local.azs
  cidr = var.vpc_cidr

  public_subnets   = local.public_subnets
  private_subnets  = local.private_subnets
  database_subnets = local.database_subnets

  create_igw         = var.create_igw
  enable_nat_gateway = var.enable_nat_gateway

  create_database_subnet_group           = true
  create_database_nat_gateway_route      = false
  create_database_internet_gateway_route = false

  # IGW tags
  igw_tags = {
    Name = "${var.vpc_name}-internet-gateway"
  }

}
