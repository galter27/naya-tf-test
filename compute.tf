resource "aws_key_pair" "naya_key" {
  key_name   = "naya_key"
  public_key = file("naya_key_rsa.pub") 
}

module "bastion_ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.1"

  name = "bastion host"

  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.naya_key.key_name
  monitoring                  = false
  associate_public_ip_address = true
  vpc_security_group_ids      = [module.bastion_sg.security_group_id]
  subnet_id                   = module.naya_vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "Naya"
  }
}


module "postgres_client_ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.1"

  name = "postgres client"

  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.naya_key.key_name
  monitoring                  = false
  vpc_security_group_ids      = [module.private_sg.security_group_id]
  subnet_id                   = module.naya_vpc.private_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "Naya"
  }
}

module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"
  version = "7.16.0"
  depends_on = [ module.naya-rds ]

  function_name = "rds-lambda"
  description   = "Save data in postgres"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.11"
  
  create_package         = false
  local_existing_package = "./lambda.zip"

  vpc_subnet_ids         = module.private_sg.subnet_id

  environment_variables = {
    DB_HOST   = "naya-rds.cns4gguas8r0.il-central-1.rds.amazonaws.com"
    DB_USER   = "postgres"
    DB_NAME   = "postgres"
    DB_PASSWORD = "password" 
    PORT = 5432
  }

  tags = {
    Name = "rds-lambda"
  }
}