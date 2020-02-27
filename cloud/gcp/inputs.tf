# GCP Integration specific

variable "gcp_service_account_id" {
  description = "GCP service account id for use with the SignalFX GCP integration"
  type        = string
  default     = ""
}

variable "gcp_project_id" {
  description = "GCP project id for use with the SignalFX GCP integration"
  type        = string
}
