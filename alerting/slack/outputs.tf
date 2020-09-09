output "sfx_integration_id" {
  description = "SignalFx integration ID"
  value       = signalfx_slack_integration.sfx_integration.id
}

output "sfx_integration_name" {
  description = "SignalFx integration name"
  value       = signalfx_slack_integration.sfx_integration.name
}

output "sfx_integration_notification" {
  description = "SignalFx integration formatted notification"
  value       = format("Slack,%s,%s", signalfx_slack_integration.sfx_integration.id, var.slack_channel_name)
}
