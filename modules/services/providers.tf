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
