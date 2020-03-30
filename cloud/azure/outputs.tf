output "azure_ad_sp_app_id" {
  description = "The Azure Service Principal App ID of the SignalFx integration"
  value       = azuread_application.signalfx_integration.application_id
}

output "azure_ad_sp_object_id" {
  description = "The Azure Service Principal Object ID of the SignalFx integration"
  value       = azuread_service_principal.signalfx_integration_sp.object_id
}
