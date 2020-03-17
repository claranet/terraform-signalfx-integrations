resource "signalfx_pagerduty_integration" "sfx_integration" {
  name    = "PagerdutyIntegration${var.suffix == "" ? "" : "-${title(var.suffix)}"}"
  enabled = var.enabled
  api_key = var.api_key
}
