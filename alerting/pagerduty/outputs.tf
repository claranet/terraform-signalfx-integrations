output "sfx_integration_id" {
  description = "SignalFx integration ID"
  value       = signalfx_pagerduty_integration.sfx_integration.id
}

output "sfx_integration_name" {
  description = "SignalFx integration name"
  value       = signalfx_pagerduty_integration.sfx_integration.name
}

output "sfx_integration_notification" {
  description = "SignalFx integration formatted notification"
  value       = format("PagerDuty,%s", signalfx_pagerduty_integration.sfx_integration.id)
}

