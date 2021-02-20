locals {
  integration_name = "GCPIntegration${var.suffix == "" ? "" : "-${title(var.suffix)}"}"
}

# "Named token to use for ingest on the SignalFx GCP integration"
resource "signalfx_org_token" "gcp_integration" {
  name        = local.integration_name
  description = "Org token for ingesting data from ${local.integration_name} GCP integration"

  notifications = var.notifications_limits
  dynamic "host_or_usage_limits" {
    for_each = var.host_or_usage_limits != null ? [1] : []
    content {
      host_limit = lookup(var.host_or_usage_limits, "host_limit", null)
      host_notification_threshold = lookup(var.host_or_usage_limits, "host_notification_threshold", null)
      container_limit = lookup(var.host_or_usage_limits, "container_limit", null)
      container_notification_threshold = lookup(var.host_or_usage_limits, "container_notification_threshold", null)
      custom_metrics_limit = lookup(var.host_or_usage_limits, "custom_metrics_limit", null)
      custom_metrics_notification_threshold = lookup(var.host_or_usage_limits, "custom_metrics_notification_threshold", null)
      high_res_metrics_limit = lookup(var.host_or_usage_limits, "high_res_metrics_limit", null)
      high_res_metrics_notification_threshold = lookup(var.host_or_usage_limits, "high_res_metrics_notification_threshold", null)
    }
  }
}

data "signalfx_gcp_services" "gcp_services" {
}

resource "signalfx_gcp_integration" "gcp_integration" {
  name        = local.integration_name
  enabled     = var.enabled
  named_token = signalfx_org_token.gcp_integration.name
  poll_rate   = var.poll_rate
  services    = coalescelist(var.services, data.signalfx_gcp_services.gcp_services.services[*].name)
  whitelist   = var.gcp_compute_metadata_whitelist

  project_service_keys {
    project_id  = var.gcp_project_id
    project_key = base64decode(google_service_account_key.sak.private_key)
  }

  depends_on = [google_project_iam_member.sfx_service_account_membership]
}
