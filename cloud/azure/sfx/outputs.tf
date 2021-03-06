output "signalfx_integration_name" {
  description = "The SignalFx integration name for Azure"
  value       = signalfx_azure_integration.azure_integration.name
}

output "signalfx_integration_services" {
  description = "The list of Azure services configured in SignalFx integration"
  value       = signalfx_azure_integration.azure_integration.services
}

output "signalfx_integration_subscriptions" {
  description = "The Azure subscriptions ids configured in the SignalFx integration"
  value       = signalfx_azure_integration.azure_integration.subscriptions
}

output "signalfx_integration_tenant" {
  description = "The Azure tenant id configured in the SignalFx integration"
  value       = signalfx_azure_integration.azure_integration.tenant_id
}

output "signalfx_integration_poll_rate" {
  description = "The Azure poll rate configured in the SignalFx integration"
  value       = signalfx_azure_integration.azure_integration.poll_rate
}
