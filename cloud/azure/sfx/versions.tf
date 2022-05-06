terraform {
  required_providers {
    signalfx = {
      source  = "splunk-terraform/signalfx"
      version = "~> 6.11"
    }
  }
  required_version = ">= 0.13"
}
