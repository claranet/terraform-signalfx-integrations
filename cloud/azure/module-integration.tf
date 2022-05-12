module "sfx_integration" {
  source = "./sfx"

  enabled              = var.enabled
  poll_rate            = var.poll_rate
  suffix               = var.suffix
  host_or_usage_limits = var.host_or_usage_limits
  notifications_limits = var.notifications_limits

  services            = var.services
  excluded_services   = var.excluded_services
  additional_services = var.additional_services

  resource_filter_rules         = var.resource_filter_rules
  custom_namespaces_per_service = var.custom_namespaces_per_service
  sync_guest_os_namespaces      = var.sync_guest_os_namespaces

  azure_tenant_id            = var.azure_tenant_id
  azure_subscription_ids     = var.azure_subscription_ids
  azure_sp_application_id    = azuread_application.signalfx_integration.application_id
  azure_sp_application_token = azuread_service_principal_password.signalfx_integration_sp_pwd.value
}
