output "sfx_integration_id" {
  description = "SignalFx integration ID"
  value       = signalfx_pagerduty_integration.sfx_integration.id
}

output "sfx_integration_notification" {
  description = "SignalFx integration notification"
  value       = format("PagerDuty,%s", signalfx_pagerduty_integration.sfx_integration.id)
}
