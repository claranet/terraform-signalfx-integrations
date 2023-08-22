terraform {
  required_providers {
    signalfx = {
      source  = "splunk-terraform/signalfx"
      version = ">= 6.9.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
  required_version = ">= 1.0"
}
