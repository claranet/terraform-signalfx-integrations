terraform {
  required_providers {
    signalfx = {
      source  = "splunk-terraform/signalfx"
      version = ">= 6.7.10"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2"
    }
  }
  required_version = ">= 0.12.26"
}
