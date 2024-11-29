#---------------------------------------------------------------
# General Vars
#---------------------------------------------------------------

variable "owner" {
  description = "The owner of the project"
  type        = string
  default     = "galter"
}

#---------------------------------------------------------------
# VPC Vars
#---------------------------------------------------------------

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "naya-vpc"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_count_public" {
  type        = number
  description = "The number of public subnets."
  default     = 1
}

variable "subnet_count_private" {
  type        = number
  description = "The number of private subnets."
  default     = 1
}

variable "subnet_count_database" {
  type        = number
  description = "The number of database subnets."
  default     = 2
}

variable "create_igw" {
  description = "Create an Internet Gateway for the VPC"
  type        = bool
  default     = true
}

variable "enable_nat_gateway" {
  description = "Enable NAT gateway for the VPC"
  type        = bool
  default     = false
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "private_subnets" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.101.0/24"]
}

variable "database_subnets" {
  description = "CIDR blocks for database subnets"
  type        = list(string)
  default     = ["10.0.201.0/24", "10.0.202.0/24"]
}

#---------------------------------------------------------------
# Security Groups Vars
#---------------------------------------------------------------

variable "bastion_sg_name" {
  description = "Name of the bastion security group"
  type        = string
  default     = "bastion-sg"
}

variable "private_sg_name" {
  description = "Name of the private security group"
  type        = string
  default     = "private-sg"
}

variable "database_sg_name" {
  description = "Name of the database security group"
  type        = string
  default     = "database-sg"
}

#---------------------------------------------------------------
# Compute Resources Vars
#---------------------------------------------------------------

variable "key_name" {
  description = "Name of the key pair."
  type        = string
  default     = "naya_key"

}

variable "public_key" {
  description = "Name of the public key."
  type        = string
  default     = "naya_key_rsa.pub"
}

variable "bastion_name" {
  description = "The name of the bastion host EC2 instance"
  type        = string
  default     = "bastion host"
}

variable "postgres_client_name" {
  description = "The name of the bastion host EC2 instance"
  type        = string
  default     = "bastion host"
}