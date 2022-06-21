terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.65.0"
    }
  }
  cloud {
    organization = "santospedroh"
    workspaces {
      name = "gh-actions-demo"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}