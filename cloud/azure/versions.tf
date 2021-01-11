terraform {
  required_providers {
    signalfx = {
      source  = "splunk-terraform/signalfx"
      version = ">= 4.26.4"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 1"
    }
  }
  required_version = ">= 0.12.26"
}
