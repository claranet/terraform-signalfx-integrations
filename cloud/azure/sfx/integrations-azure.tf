data "signalfx_azure_services" "azure_services" {
}

resource "signalfx_azure_integration" "azure_integration" {
  name        = local.integration_name
  enabled     = var.enabled
  environment = "azure"

  poll_rate = var.poll_rate


  app_id     = var.azure_sp_application_id
  secret_key = var.azure_sp_application_token

  services = coalescelist(var.services, data.signalfx_azure_services.azure_services.services[*].name)

  tenant_id     = var.azure_tenant_id
  subscriptions = var.azure_subscription_ids
}
