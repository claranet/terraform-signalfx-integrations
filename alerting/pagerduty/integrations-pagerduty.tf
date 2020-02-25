resource "signalfx_pagerduty_integration" "pagerduty_claranet" {
	name = "PD - Claranet"
	enabled = var.enable_flag
	api_key = var.api_key
}
