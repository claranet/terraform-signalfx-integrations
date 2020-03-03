output "aws_role_arn" {
  description = "The role ARN of the SignalFx integration"
  value       = aws_iam_role.sfx_role.arn
}

output "aws_role_name" {
  description = "The IAM role name of the SignalFx integration"
  value       = aws_iam_role.sfx_role.name
}

output "sfx_integration_id" {
  description = "SignalFX integration ID"
  value       = signalfx_aws_integration.sfx_integration.integration_id
}

output "sfx_external_id" {
  description = "SignalFX integration external ID"
  value       = signalfx_aws_integration.sfx_integration.external_id
}

