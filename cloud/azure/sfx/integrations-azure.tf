data "signalfx_azure_services" "azure_services" {
}

resource "signalfx_azure_integration" "azure_integration" {
  name        = local.integration_name
  enabled     = var.enabled
  named_token = signalfx_org_token.azure_integration.name
  environment = "azure"

  poll_rate = var.poll_rate

  app_id     = var.azure_sp_application_id
  secret_key = var.azure_sp_application_token

  services = coalescelist(var.services, data.signalfx_azure_services.azure_services.services[*].name)

  tenant_id     = var.azure_tenant_id
  subscriptions = var.azure_subscription_ids
}

# "Named token to use for ingest on the SignalFx Azure integration"
resource "signalfx_org_token" "azure_integration" {
  name        = local.integration_name
  description = "Org token for ingesting data from ${local.integration_name} Azure integration"

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

