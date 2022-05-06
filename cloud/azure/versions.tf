terraform {
  required_providers {
    signalfx = {
      source  = "splunk-terraform/signalfx"
      version = "~> 6.11"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
  }
  required_version = ">= 0.13"
}
