locals {
  sfx_suffix               = var.sfx_integration_name_suffix == "" ? "" : format("-%s", var.sfx_integration_name_suffix)
  default_integration_name = format("AzureSignalFxIntegration%s", local.sfx_suffix)
}
