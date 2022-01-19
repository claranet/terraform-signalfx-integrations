# Global

variable "suffix" {
  description = "Webhook name suffix, will precede the notif period"
  type        = string
  default     = "proxy-alerting"
}

# Proxy-Alerting Integration specific

variable "enabled" {
  description = "Whether the Webhook integration is enabled"
  type        = bool
  default     = true
}

variable "url" {
  description = "The proxy-alerting URL to use"
  type        = string
  default     = "https://proxy-alerting.fr.clara.net/api/signalfx"
}

variable "project_id" {
  type        = string
  default     = null
  description = "Project ID to add to the project-id header"
}

variable "username" {
  description = "The proxy-alerting username to authentificate"
  type        = string
}

variable "password" {
  description = "The proxy-alerting password to authentificate"
  type        = string
}

variable "alerting_ho" {
  type        = bool
  default     = true
  description = "HO / HNO header"
}

variable "additional_headers" {
  description = "Any additional headers to send"
  type        = map(any)
  default     = {}
}

