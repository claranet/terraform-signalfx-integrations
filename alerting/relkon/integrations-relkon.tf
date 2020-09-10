resource "signalfx_webhook_integration" "sfx_integration" {
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
  headers {
    header_key   = "X-Relkon-Host-Severity"
    header_value = var.host_severity
  }
  dynamic "headers" {
    for_each = var.additional_headers
    content {
      header_key   = headers.key
      header_value = headers.value
    }
  }
}

