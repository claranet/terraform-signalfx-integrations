locals {
  integration_name = format("AzureSignalFxIntegration%s", title(var.suffix))
  azure_services   = coalescelist(var.services, data.signalfx_azure_services.azure_services.services[*].name)
}
