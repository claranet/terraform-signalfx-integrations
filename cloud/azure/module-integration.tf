module "sfx_integration" {
  source = "./sfx"

  enabled              = var.enabled
  poll_rate            = var.poll_rate
  host_or_usage_limits = var.host_or_usage_limits
  notifications_limits = var.notifications_limits

  services          = var.services
  excluded_services = var.excluded_services
  suffix            = var.suffix

  azure_tenant_id            = var.azure_tenant_id
  azure_subscription_ids     = var.azure_subscription_ids
  azure_sp_application_id    = azuread_application.signalfx_integration.application_id
  azure_sp_application_token = azuread_service_principal_password.signalfx_integration_sp_pwd.value
}
