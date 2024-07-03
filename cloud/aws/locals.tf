locals {
  integration_name = var.signalfx_token_name != null && var.signalfx_token_name != "" ? var.signalfx_token_name : "AWSIntegration${var.suffix == "" ? "" : "-${title(var.suffix)}"}"

  monitored_services = setsubtract(
    concat(var.included_services, var.extra_included_services),
    # ec2 is always monitored by this module
    # and is handled by a dedicated variable ec2_namespace_sync_rule
    # (it's normal it doesn't appear in monitored_services)
    concat(var.excluded_services, ["AWS/EC2"]),
  )
}
