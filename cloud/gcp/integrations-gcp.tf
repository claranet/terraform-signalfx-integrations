locals {
  integration_name = "GCPIntegration${var.suffix == "" ? "" : "-${title(var.suffix)}"}"
}

# "Named token to use for ingest on the SignalFx GCP integration"
resource "signalfx_org_token" "gcp_claranet_integration" {
  name        = local.integration_name
  description = "Org token for ingesting data from ${local.integration_name} GCP integration"

  # Where to send notifications about this token's limits. Please consult the Notification Format laid out in detectors
  # notifications = ["Email,foo-alerts@bar.com"]

  # host_or_usage_limits {
  #   host_limit                              = 100
  #   host_notification_threshold             = 90
  #   container_limit                         = 200
  #   container_notification_threshold        = 180
  #   custom_metrics_limit                    = 1000
  #   custom_metrics_notification_threshold   = 900
  #   high_res_metrics_limit                  = 1000
  #   high_res_metrics_notification_threshold = 900
  # }
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
