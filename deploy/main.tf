terraform {

  # the backend (where tf stores state) should be the same per environment
  # @TODO: can't find a proper way to do this, so we'll just hardcode it
  backend "s3" {
    bucket  = "360-ac-dev-terraform-state"
    key     = "tasks/test.tfstate"
    region  = "eu-west-3"
    profile = "ac-dev"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
}
