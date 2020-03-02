variable "enabled" {
  description = "(Required) Whether the integration is enabled"
  default     = "true"
}

variable "poll_rate" {
  description = "(Optional) AWS poll rate (in seconds). One of 60 or 300."
  default     = 300
}

variable "suffix" {
  description = "Optional suffix to identify and avoid duplication of unique resources"
  type        = string
  default     = ""
}

variable "gcp_service_account_id" {
  description = "GCP service account id for use with the SignalFX GCP integration"
  type        = string
  default     = ""
}

variable "gcp_project_id" {
  description = "GCP project id for use with the SignalFX GCP integration"
  type        = string
}

