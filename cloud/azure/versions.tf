terraform {
  required_providers {
    signalfx = {
      source  = "splunk-terraform/signalfx"
      version = ">= 6.7.10"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2"
    }
  }
  required_version = ">= 0.12.26"
}
