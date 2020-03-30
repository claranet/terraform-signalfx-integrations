
terraform {
  required_version = ">= 0.12"
  required_providers {
    azurerm  = "~> 1.44"
    azuread  = "~> 0.7"
    signalfx = "~> 4"
  }
}
