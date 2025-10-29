terraform {
  required_version = "1.13.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.18.0"
    }
  }

}

provider "aws" {
  region  = "ap-southeast-1"
  profile = "plasabas-general-admin"

  default_tags {
    tags = {
      ManagedBy = "Terraform"
    }
  }

}