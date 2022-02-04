terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 3.8.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.63.0"
    }
  }
}

#Configure the Cloudflare provider
provider "cloudflare" {
  email   = var.cf_email
  api_key = var.cf_apikey
}

#Configure the AWS provider
provider "aws" {
  region = var.aws_region
}
