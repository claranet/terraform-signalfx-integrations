terraform {
  required_providers {
    signalfx = {
      source  = "splunk-terraform/signalfx"
      version = ">= 4.26.4"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 1.44"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = ">= 0.8"
    }
  }
  required_version = ">= 0.12.26"
}
