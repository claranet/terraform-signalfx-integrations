resource "signalfx_webhook_integration" "relkon" {
  name    = format("%s_%s", var.suffix, var.notification_period)
  enabled = var.enabled
  url     = var.relkon_url

  headers {
    header_key   = "X-Relkon-Notification-Period"
    header_value = var.notification_period
  }
  headers {
    header_key   = "X-Relkon-Token"
    header_value = var.relkon_token
  }
}

