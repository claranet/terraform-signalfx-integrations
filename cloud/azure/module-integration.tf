module "sfx-integration" {
  source = "./sfx"

  enabled   = var.enabled
  poll_rate = var.poll_rate
  services  = var.services
  suffix    = var.suffix

  azure_tenant_id            = var.azure_tenant_id
  azure_subscription_ids     = var.azure_subscription_ids
  azure_sp_application_id    = azuread_application.signalfx_integration.application_id
  azure_sp_application_token = azuread_service_principal_password.signalfx_integration_sp_pwd.value
}
