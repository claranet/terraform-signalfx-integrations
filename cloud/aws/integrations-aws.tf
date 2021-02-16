resource "signalfx_org_token" "aws_integration" {
  name        = local.integration_name
  description = "Org token for ingesting data from ${local.integration_name} AWS integration"

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

