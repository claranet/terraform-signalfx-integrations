resource "signalfx_webhook_integration" "sfx_integration" {
  name    = local.integration_name
  enabled = var.enabled
  url     = var.url
  headers {
    header_key   = "Authorization"
    header_value = "Bearer ${var.token}"
  }
  dynamic "headers" {
    for_each = var.additional_headers
    content {
      header_key   = headers.key
      header_value = headers.value
    }
  }
}
