# Global

variable "suffix" {
  description = "Optional suffix to identify and avoid duplication of unique resources"
  type        = string
  default     = ""
}

# Slack Integration specific

variable "enabled" {
  description = "Whether the PagerDuty integration is enabled"
  type        = bool
  default     = true
}

variable "webhook_url" {
  description = "Slack webhook URL"
  type        = string
}

variable "slack_channel_name" {
  description = "Slack channel on which send the notifications (without #, only used to generated formatted notification output)."
  type        = string
}
