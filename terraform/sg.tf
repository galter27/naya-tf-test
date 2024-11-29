module "bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name        = var.bastion_sg_name
  description = "Security group for bastion host"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Allow SSH access from local machine"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

    egress_with_cidr_blocks = [
  {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  },
  {
    from_port   = -1      # ICMP type (any)
    to_port     = -1      # ICMP code (any)
    protocol    = "icmp"  # Specify ICMP protocol
    cidr_blocks = "0.0.0.0/0"
  }
]
  
  tags = merge(
  local.tags,
  {
    Name = var.bastion_sg_name
  }
  )

}

module "private_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name        = var.private_sg_name
  description = "Security group for private resources"
  vpc_id      = module.vpc.vpc_id

  ingress_with_source_security_group_id = [
    {   
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Allow SSH access from bastion security group"
      source_security_group_id = module.bastion_sg.security_group_id 
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = "10.0.0.0/16" # Allow outbound traffic only within the VPC
    }
  ]

  tags = merge(
  local.tags,
  {
    Name = var.private_sg_name
  }
  )
}

module "database_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name        = var.database_sg_name
  description = "Security group for database with postgres port open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_with_source_security_group_id = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "Allow PostgreSQL access from private EC2 instances"
      source_security_group_id = module.private_sg.security_group_id
    }
  ]

  tags = merge(
  local.tags,
  {
    Name = var.database_sg_name
  }
  )
}