# Global

variable "suffix" {
  description = "Optional suffix to identify and avoid duplication of unique resources"
  type        = string
  default     = ""
}

# PagerDuty Integration specific

variable "enabled" {
  description = "Whether the PagerDuty integration is enabled"
  type        = bool
  default     = true
}

variable "api_key" {
  description = "Pagerduty API token"
  type        = string
}
