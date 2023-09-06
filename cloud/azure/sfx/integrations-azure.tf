resource "signalfx_azure_integration" "azure_integration" {
  name        = local.integration_name
  enabled     = var.enabled
  named_token = var.signalfx_token_name != null ? var.signalfx_token_name : one(signalfx_org_token.azure_integration[*].name)
  environment = "azure"

  poll_rate = var.poll_rate

  app_id     = var.azure_sp_application_id
  secret_key = var.azure_sp_application_token

  services            = setsubtract(var.services, var.excluded_services)
  additional_services = var.additional_services

  dynamic "resource_filter_rules" {
    for_each = var.resource_filter_rules != null ? var.resource_filter_rules : []
    content {
      filter = {
        source = lookup(resource_filter_rules.value.filter, "source", null)
      }
    }
  }

  sync_guest_os_namespaces = var.sync_guest_os_namespaces
  dynamic "custom_namespaces_per_service" {
    for_each = var.custom_namespaces_per_service != null ? var.custom_namespaces_per_service : []
    content {
      service    = custom_namespaces_per_service.value.service
      namespaces = custom_namespaces_per_service.value.namespaces
    }
  }

  tenant_id     = var.azure_tenant_id
  subscriptions = var.azure_subscription_ids
}

# "Named token to use for ingest on the SignalFx Azure integration"
# We need a specific token to avoid using the Default organization one.
resource "signalfx_org_token" "azure_integration" {
  count       = var.signalfx_token_name != null && var.signalfx_token_name != "" ? 0 : 1
  name        = local.integration_name
  description = "Org token for ingesting data from ${local.integration_name} Azure integration"

  notifications = var.notifications_limits
  dynamic "host_or_usage_limits" {
    for_each = var.host_or_usage_limits != null ? [1] : []
    content {
      host_limit                              = lookup(var.host_or_usage_limits, "host_limit", null)
      host_notification_threshold             = lookup(var.host_or_usage_limits, "host_notification_threshold", null)
      container_limit                         = lookup(var.host_or_usage_limits, "container_limit", null)
      container_notification_threshold        = lookup(var.host_or_usage_limits, "container_notification_threshold", null)
      custom_metrics_limit                    = lookup(var.host_or_usage_limits, "custom_metrics_limit", null)
      custom_metrics_notification_threshold   = lookup(var.host_or_usage_limits, "custom_metrics_notification_threshold", null)
      high_res_metrics_limit                  = lookup(var.host_or_usage_limits, "high_res_metrics_limit", null)
      high_res_metrics_notification_threshold = lookup(var.host_or_usage_limits, "high_res_metrics_notification_threshold", null)
    }
  }
}

