output "gcp_service_account_id" {
  description = "The GCP service account id used by SignalFx"
  value       = local.id_to_use
}

output "signalfx_named_token" {
  description = "The SignalFx named token used by the GCP integration"
  value = {
    (signalfx_org_token.gcp_claranet_integration.name) = signalfx_org_token.gcp_claranet_integration.secret
  }
}
