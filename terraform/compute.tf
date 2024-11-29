resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = file(var.public_key) 
}

module "bastion_ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.1"

  name = var.bastion_name

  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.key_pair.key_name
  monitoring                  = false
  associate_public_ip_address = true
  vpc_security_group_ids      = [module.bastion_sg.security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]

  tags = merge(
  local.tags,
  {
    Name = var.bastion_name
  }
  )
}


module "postgres_client_ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.1"

  name = var.postgres_client_name

  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.key_pair.key_name
  monitoring                  = false
  vpc_security_group_ids      = [module.private_sg.security_group_id]
  subnet_id                   = module.vpc.private_subnets[0]

  tags = merge(
  local.tags,
  {
    Name = var.postgres_client_name
  }
  )
}

module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"
  version = "7.16.0"
  depends_on = [module.rds_postgres]

  function_name = "rds-lambda"
  description   = "Save data in postgres"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.11"

  # Lambda VPC and Security Groups
  vpc_subnet_ids         = module.vpc.private_subnets
  vpc_security_group_ids = [module.private_sg.security_group_id]

  # Lambda environment variables (database connection details)
  environment_variables = {
    DB_HOST     = "naya-rds.cns4gguas8r0.il-central-1.rds.amazonaws.com"
    DB_NAME     = "postgres"
    DB_USER     = "postgres"
    DB_PASSWORD = "password"
    DB_PORT     = "5432"
  }

  create_package         = false
  local_existing_package = "./lambda.zip"

  attach_network_policy = true

  tags = merge(
  local.tags,
  {
    Name = "RDS-Lambda"
  }
  )
}