terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }

    signalfx = {
      source  = "splunk-terraform/signalfx"
      version = ">= 8.1.0"
    }

    time = {
      source  = "hashicorp/time"
      version = ">= 0.9.1"
    }
  }

  required_version = ">= 1.0"
}
