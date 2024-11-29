module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.16.0"

  name                 = var.vpc_name
  azs                  = local.azs
  cidr                 = var.vpc_cidr
  
  public_subnets       = local.public_subnets
  private_subnets      = local.private_subnets
  database_subnets     = local.database_subnets

  create_igw           = var.create_igw
  enable_nat_gateway   = var.enable_nat_gateway
  
  create_database_subnet_group           = true
  create_database_nat_gateway_route      = false 
  create_database_internet_gateway_route = false

  tags = merge(
  local.tags,
  {
    Name = var.vpc_name
  }
  )
}

# Modify subnet names
resource "aws_ec2_tag" "public_subnets_name" {
  count = length(module.vpc.public_subnets)

  resource_id = module.vpc.public_subnets[count.index]
  key         = "Name"
  value       = "${var.vpc_name}-public-${count.index + 1}"
}

resource "aws_ec2_tag" "private_subnets_name" {
  count = length(module.vpc.private_subnets)

  resource_id = module.vpc.private_subnets[count.index]
  key         = "Name"
  value       = "${var.vpc_name}-private-${count.index + 1}"
}

resource "aws_ec2_tag" "database" {
  count = length(module.vpc.database_subnets)

  resource_id = module.vpc.database_subnets[count.index]
  key         = "Name"
  value       = "${var.vpc_name}-database-${count.index + 1}"
}