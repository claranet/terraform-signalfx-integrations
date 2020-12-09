# Global

variable "suffix" {
  description = "Webhook name suffix, will precede the notif period"
  type        = string
  default     = "dasboardunifie"
}

# Dashboard Integration specific

variable "enabled" {
  description = "Whether the Webhook integration is enabled"
  type        = bool
  default     = true
}

variable "dashboardunifie_url" {
  description = "Dashboard API endpoint"
  type        = string
}

variable "project_id" {
  type        = string
  default     = null
  description = "Project ID to add to the project-id header"
}

variable "username" {
  description = "Dashboard API username"
  type        = string
}

variable "password" {
  description = "Dashboard API password"
  type        = string
}

variable "additional_headers" {
  description = "Any additional headers to send"
  type        = map(any)
  default     = {}
}

locals {
  base64header = base64encode("${var.username}:${var.password}")
}
