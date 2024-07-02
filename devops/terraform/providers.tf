terraform {
  required_version = ">1.4"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

}

provider "aws" {
  region = var.REGION
}

