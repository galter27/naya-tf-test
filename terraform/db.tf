module "rds_postgres" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "naya-rds"

  engine               = "postgres"
  engine_version       = "14"
  family               = "postgres14"
  major_engine_version = "14"
  instance_class       = "db.t4g.micro"
  allocated_storage    = 10

  db_name                     = "postgres"
  username                    = "postgres"
  password                    = "password"
  port                        = "5432"
  manage_master_user_password = false

  multi_az               = false
  db_subnet_group_name   = module.vpc.database_subnet_group
  vpc_security_group_ids = [module.database_sg.security_group_id]

  skip_final_snapshot = true

  tags = local.tags

  # Database Deletion Protection
  deletion_protection = false
}
