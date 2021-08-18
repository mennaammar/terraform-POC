terraform {
  required_version = ">= 0.12.6"

  required_providers {
    #aws = ">= 3.24"
    aws = ">= 3.36"
  }
    backend "s3" {
      encrypt = true
       region = "eu-west-1"
      bucket = "terraform-state-maf-demo"
      key = "terraform.tfstate"
    }
}
