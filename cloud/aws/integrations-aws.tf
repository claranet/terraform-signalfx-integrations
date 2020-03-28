resource "signalfx_aws_external_integration" "sfx_integration_external" {
  name = "AWSIntegration${var.suffix == "" ? "" : "-${title(var.suffix)}"}"
}

resource "signalfx_aws_integration" "sfx_integration" {
  enabled = var.enabled

  integration_id             = signalfx_aws_external_integration.sfx_integration_external.id
  external_id                = signalfx_aws_external_integration.sfx_integration_external.external_id
  role_arn                   = aws_iam_role.sfx_role.arn
  regions                    = var.aws_regions
  poll_rate                  = var.poll_rate
  import_cloud_watch         = var.import_cloudwatch
  enable_aws_usage           = var.import_aws_usage
  use_get_metric_data_method = var.use_get_metric_data

  namespace_sync_rule {
    default_action = var.namespace_sync_rule.default_action
    filter_action  = var.namespace_sync_rule.filter_action
    filter_source  = var.namespace_sync_rule.filter_source
    namespace      = var.namespace_sync_rule.namespace
  }

  dynamic "namespace_sync_rule" {
    iterator = iter
    for_each = var.namespaces
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

