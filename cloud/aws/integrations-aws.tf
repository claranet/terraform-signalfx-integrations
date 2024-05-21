# "Named token to use for ingest on the SignalFx AWS integration"
# We need a specific token to avoid using the Default organization one.
resource "signalfx_org_token" "aws_integration" {
  count       = var.signalfx_token_name != null && var.signalfx_token_name != "" ? 0 : 1
  name        = local.integration_name
  description = "Org token for ingesting data from ${local.integration_name} AWS integration"

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

resource "signalfx_aws_external_integration" "aws_integration_external" {
  name = local.integration_name
}

resource "signalfx_aws_integration" "aws_integration" {
  enabled     = var.enabled
  named_token = var.use_metric_streams_sync == false ? var.signalfx_token_name != null ? var.signalfx_token_name : one(signalfx_org_token.aws_integration[*].name) : null

  integration_id            = signalfx_aws_external_integration.aws_integration_external.id
  external_id               = signalfx_aws_external_integration.aws_integration_external.external_id
  role_arn                  = aws_iam_role.sfx_role.arn
  regions                   = var.aws_regions
  poll_rate                 = var.poll_rate
  import_cloud_watch        = var.import_cloudwatch
  enable_aws_usage          = var.import_aws_usage
  enable_check_large_volume = var.enable_check_large_volume
  enable_logs_sync          = var.enable_logs_sync
  use_metric_streams_sync   = var.use_metric_streams_sync


  namespace_sync_rule {
    default_action = var.use_metric_streams_sync ? null : var.ec2_namespace_sync_rule.default_action
    filter_action  = var.use_metric_streams_sync ? null : var.ec2_namespace_sync_rule.filter_action
    filter_source  = var.use_metric_streams_sync ? null : var.ec2_namespace_sync_rule.filter_source
    namespace      = var.ec2_namespace_sync_rule.namespace
  }

  dynamic "namespace_sync_rule" {
    iterator = iter
    for_each = local.monitored_services
    content {
      default_action = try(lookup(var.namespace_sync_rules_filters[iter.value], "default_action", null), null)
      filter_action  = try(lookup(var.namespace_sync_rules_filters[iter.value], "filter_action", null), null)
      filter_source  = try(lookup(var.namespace_sync_rules_filters[iter.value], "filter_source", null), null)
      namespace      = iter.value
    }
  }

  dynamic "custom_namespace_sync_rule" {
    for_each = var.custom_namespace_sync_rules != null ? var.custom_namespace_sync_rules : []
    content {
      default_action = lookup(custom_namespace_sync_rule.value, "default_action", null)
      filter_action  = lookup(custom_namespace_sync_rule.value, "filter_action", null)
      filter_source  = lookup(custom_namespace_sync_rule.value, "filter_source", null)
      namespace      = custom_namespace_sync_rule.value.namespace
    }
  }

  dynamic "metric_stats_to_sync" {
    for_each = var.metrics_stats_to_sync != null ? var.metrics_stats_to_sync : []
    content {
      namespace = metric_stats_to_sync.value.namespace
      metric    = metric_stats_to_sync.value.metric
      stats     = metric_stats_to_sync.value.stats
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.sfx_policy_attach,
    aws_iam_role_policy_attachment.sfx_metric_streams_policy_attach,
    aws_iam_role_policy_attachment.sfx_logs_policy_attach,
    time_sleep.policy_availability,
    time_sleep.logs_policy_availability,
  ]
}
