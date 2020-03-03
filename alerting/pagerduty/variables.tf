# Global

variable "suffix" {
  description = "Optional suffix to identify and avoid duplication of unique resources"
  type        = string
  default     = ""
}

# PagerDuty Integration specific

variable "enabled" {
  description = "Whether the PagerDuty integration is enabled"
  default     = "true"
}

variable "api_key" {
	description = "Pagerduty API token"
}
