resource "signalfx_aws_external_integration" "aws_claranet_external" {
	name = "AWSClaranetIntegration"
}

resource "signalfx_aws_integration" "aws_claranet" {
	enabled = var.enable_flag

	integration_id = "${signalfx_aws_external_integration.aws_claranet_external.id}"
	external_id = "${signalfx_aws_external_integration.aws_claranet_external.external_id}"
	role_arn = "${aws_iam_role.aws_sfx_role.arn}"
	regions = var.aws_regions
	poll_rate = var.aws_poll_rate
	import_cloud_watch = var.import_cloud_watch_flag
	enable_aws_usage = var.enable_aws_usage_flag

	/*custom_namespace_sync_rule {
		default_action = var.custom_namespace_rules_default_action
		filter_action = var.custom_namespace_rules_filter_action
		filter_source = var.custom_namespace_rules_filter_source
		namespace = var.custom_namespace_rules_namespace
	}

	namespace_sync_rule {
		default_action = var.namespace_rules_default_action
		filter_action = var.namespace_rules_filter_action
		filter_source = var.namespace_rules_filter_source
		namespace = var.namespace_rules_namespace
	}*/
}
