terraform {
  required_providers {
    signalfx = {
      source  = "splunk-terraform/signalfx"
      version = ">= 8.0"
    }
  }
  required_version = ">= 1.0"
}
