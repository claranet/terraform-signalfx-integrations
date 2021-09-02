output "azure_ad_sp_app_id" {
  description = "The Azure Service Principal App ID of the SignalFx integration"
  value       = azuread_application.signalfx_integration.application_id
}

output "azure_ad_sp_object_id" {
  description = "The Azure Service Principal Object ID of the SignalFx integration"
  value       = azuread_service_principal.signalfx_integration_sp.object_id
}

output "azure_ad_sp_secret_key" {
  description = "The Azure Service Principal secret key of the SignalFx integration"
  value       = azuread_service_principal_password.signalfx_integration_sp_pwd.value
  sensitive   = true
}

output "azure_ad_sp_validity_end_date" {
  description = "The Azure Service Principal validity date of the SignalFx integration"
  value       = azuread_service_principal_password.signalfx_integration_sp_pwd.end_date
}

output "signalfx_integration_name" {
  description = "The SignalFx integration name for Azure"
  value       = module.sfx_integration.signalfx_integration_name
}

output "signalfx_integration_services" {
  description = "The list of Azure services configured in SignalFx integration"
  value       = module.sfx_integration.signalfx_integration_services
}

output "signalfx_integration_subscriptions" {
  description = "The Azure subscriptions ids configured in the SignalFx integration"
  value       = module.sfx_integration.signalfx_integration_subscriptions
}

output "signalfx_integration_tenant" {
  description = "The Azure tenant id configured in the SignalFx integration"
  value       = module.sfx_integration.signalfx_integration_tenant
}

output "signalfx_integration_poll_rate" {
  description = "The Azure poll rate configured in the SignalFx integration"
  value       = module.sfx_integration.signalfx_integration_poll_rate
}
