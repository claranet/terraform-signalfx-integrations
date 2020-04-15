# Global

variable "suffix" {
  description = "Webhook name suffix, will precede the notif period"
  type        = string
  default     = "relkon"
}

# Relkon Integration specific

variable "enabled" {
  description = "Whether the Webhook integration is enabled"
  type        = bool
  default     = true
}

variable "relkon_url" {
  description = "Relkon API endpoint"
  type        = string
}

variable "relkon_token" {
  description = "Relkon API token"
  type        = string
}

variable "notification_period" {
  description = "Notification period (either 24x7 or 8x5)"
  type        = string
}
