output "aws_role_arn" {
  description = "The role ARN of the SignalFx integration"
  value       = aws_iam_role.sfx_role.arn
}

output "aws_role_name" {
  description = "The IAM role name of the SignalFx integration"
  value       = aws_iam_role.sfx_role.name
}
