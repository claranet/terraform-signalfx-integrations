resource "signalfx_webhook_integration" "sfx_integration" {
  name    = format("%s", var.suffix)
  enabled = var.enabled
  url     = var.url
  headers {
    header_key   = "Authorization"
    header_value = "Basic ${local.base64header}"
  }
  headers {
    header_key   = "X-Alerting-Business-Hours-Only"
    header_value = var.alerting_ho
  }
  headers {
    header_key   = "project-id"
    header_value = var.project_id
  }
  dynamic "headers" {
    for_each = var.additional_headers
    content {
      header_key   = headers.key
      header_value = headers.value
    }
  }
}

