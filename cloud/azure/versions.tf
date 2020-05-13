
terraform {
  required_version = ">= 0.12"
  required_providers {
    azurerm  = "~> 1.44"
    azuread  = "~> 0.8"
    signalfx = ">= 4.20.1"
  }
}
