locals {
  integration_name = "GCPIntegration${var.suffix == "" ? "" : "-${title(var.suffix)}"}"
}

# "Named token to use for ingest on the SignalFx GCP integration"
resource "signalfx_org_token" "gcp_claranet_integration" {
  name        = local.integration_name
  description = "Org token for ingesting data from ${local.integration_name} GCP integration"
}

resource "signalfx_gcp_integration" "gcp_claranet_integration" {
  name        = local.integration_name
  enabled     = var.enabled
  named_token = signalfx_org_token.gcp_claranet_integration.name
  poll_rate   = var.poll_rate
  services    = var.services
  whitelist   = var.gcp_compute_metadata_whitelist

  project_service_keys {
    project_id  = var.gcp_project_id
    project_key = base64decode(google_service_account_key.sak.private_key)
  }

  depends_on = [google_project_iam_member.sfx_service_account_membership]
}
