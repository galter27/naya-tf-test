terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.78.0"
    }
  }
}

provider "aws" {
  region = "il-central-1"

  default_tags {
    tags = {
      CreatedBy   = var.owner
      Environment = "Naya"
      Terraform   = true
      GithubRepo  = "https://github.com/galter27/naya-tf-test"
    }
  }
}

