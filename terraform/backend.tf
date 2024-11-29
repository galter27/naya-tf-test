terraform {
  backend "s3" {
    bucket         = "galter-terraform-state-bucket"
    key            = "naya-tf-test"
    region         = "il-central-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}