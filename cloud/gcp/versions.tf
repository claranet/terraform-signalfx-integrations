terraform {
  required_providers {
    signalfx = {
      source  = "splunk-terraform/signalfx"
      version = ">= 6.5.0"
    }
    google = {
      source  = "hashicorp/google"
      version = ">= 3"
    }
  }
  required_version = ">= 0.12.26"
}
