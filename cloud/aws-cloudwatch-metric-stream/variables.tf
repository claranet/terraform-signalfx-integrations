variable "sfx_access_token" {
  description = "Access token used to push metrics to SignalFx"
  type        = string
}

variable "sfx_ingest_url" {
  description = "Ingest URL used to push metrics to SignalFx"
  type        = string
}

variable "cloudwatch_log_group_retention_in_days" {
  description = "AWS CloudWatch log group retention in days"
  type        = number
  default     = 14
}
