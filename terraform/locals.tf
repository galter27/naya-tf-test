locals {
  vpc_name           = var.vpc_name
  vpc_cidr           = var.vpc_cidr
  subnet_prefix      = "${local.vpc_name}-subnet"
  route_table_prefix = "${local.vpc_name}-route-table"
  azs                = slice(data.aws_availability_zones.available.names, 0, max(var.subnet_count_public, var.subnet_count_private, var.subnet_count_database))

  public_subnets = [
    for i in range(var.subnet_count_public) :
    cidrsubnet(local.vpc_cidr, 8, i)
  ]

  private_subnets = [
    for i in range(var.subnet_count_private) :
    cidrsubnet(local.vpc_cidr, 8, i + 100)
  ]

  database_subnets = [
    for i in range(var.subnet_count_database) :
    cidrsubnet(local.vpc_cidr, 8, i + 200)
  ]

}