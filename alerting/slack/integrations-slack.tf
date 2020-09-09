resource "signalfx_slack_integration" "sfx_integration" {
  name        = "SlackIntegration${var.suffix == "" ? "" : "-${title(var.suffix)}"}"
  enabled     = var.enabled
  webhook_url = var.webhook_url
}
