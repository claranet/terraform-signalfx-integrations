output "aws_role_arn" {
  description = "The role ARN of the SignalFx integration"
  value       = aws_iam_role.sfx_role.arn
}

output "aws_role_name" {
  description = "The IAM role name of the SignalFx integration"
  value       = aws_iam_role.sfx_role.name
}

output "aws_integration_id" {
  description = "SignalFx integration ID"
  value       = signalfx_aws_integration.aws_integration.integration_id
}

output "sfx_external_id" {
  description = "SignalFx integration external ID"
  value       = signalfx_aws_integration.aws_integration.external_id
}

