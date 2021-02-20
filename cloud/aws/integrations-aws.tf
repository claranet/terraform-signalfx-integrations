resource "signalfx_org_token" "aws_integration" {
  name        = local.integration_name
  description = "Org token for ingesting data from ${local.integration_name} AWS integration"

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

data "signalfx_aws_services" "aws_services" {
}

resource "signalfx_aws_external_integration" "aws_integration_external" {
  name = local.integration_name
}

resource "signalfx_aws_integration" "aws_integration" {
  enabled     = var.enabled
  named_token = signalfx_org_token.aws_integration.name

  integration_id             = signalfx_aws_external_integration.aws_integration_external.id
  external_id                = signalfx_aws_external_integration.aws_integration_external.external_id
  role_arn                   = aws_iam_role.sfx_role.arn
  regions                    = var.aws_regions
  poll_rate                  = var.poll_rate
  import_cloud_watch         = var.import_cloudwatch
  enable_aws_usage           = var.import_aws_usage
  use_get_metric_data_method = var.use_get_metric_data

  namespace_sync_rule {
    default_action = var.ec2_namespace_sync_rule.default_action
    filter_action  = var.ec2_namespace_sync_rule.filter_action
    filter_source  = var.ec2_namespace_sync_rule.filter_source
    namespace      = var.ec2_namespace_sync_rule.namespace
  }

  dynamic "namespace_sync_rule" {
    iterator = iter
    for_each = local.open_aws_services
    content {
      namespace = iter.value
    }
  }

  custom_namespace_sync_rule {
    default_action = var.custom_namespace_sync_rule.default_action
    filter_action  = var.custom_namespace_sync_rule.filter_action
    filter_source  = var.custom_namespace_sync_rule.filter_source
    namespace      = var.custom_namespace_sync_rule.namespace
  }
}

