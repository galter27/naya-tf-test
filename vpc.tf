module "naya_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.16.0"

  name = "naya-vpc" 
  azs             = ["il-central-1a", "il-central-1b", "il-central-1c"] 
  cidr                 = "10.0.0.0/16"

  # Subnet for bastion
  public_subnets  = ["10.0.1.0/24"] 
  create_igw      = true 
  
  # Subnet for ec2 instances
  private_subnets = ["10.0.101.0/24"]
  
  # Subnet for RDS
  database_subnets     = ["10.0.201.0/24", "10.0.202.0/24"]
  create_database_subnet_group           = true
  create_database_nat_gateway_route      = false 
  create_database_internet_gateway_route = false
    
  enable_nat_gateway = false
}