# Global

variable "suffix" {
  description = "Optional suffix to identify and avoid duplication of unique resources"
  type        = string
  default     = ""
}

# Azure Integration specific

variable "enabled" {
  description = "Whether the Azure integration is enabled"
  type        = bool
  default     = true
}

variable "poll_rate" {
  description = "Azure poll rate in seconds (One of 60 or 300)"
  type        = number
  default     = 300
}

variable "host_or_usage_limits" {
  description = "Specify Usage-based limits for this integration"
  type        = map(number)
  default     = null
}

variable "notifications_limits" {
  description = "Where to send notifications about this token's limits"
  type        = list(string)
  default     = null
}

variable "services" {
  description = "Azure service metrics to import. Empty list imports all services"
  type        = list(string)
  default     = []
}

variable "excluded_services" {
  description = "List of Azure services to not collect metrics for (removed from the `services` list)"
  type        = list(string)
  default     = []
}

variable "additional_services" {
  description = "Not yet officially supported Azure resource types to sync with SignalFx as custom metrics"
  type        = list(string)
  default     = null
}

variable "resource_filter_rules" {
  description = "List of rules for filtering Azure resources by their tags. Each filter follows \"filter('key', 'value')\". Referenced keys are limited to tags and must start with the \"azure_tag_\" prefix"
  type = list(object({
    filter = object({
      source = string
    })
  }))
  default = null
}

variable "sync_guest_os_namespaces" {
  description = "Sync additional namespaces for VMs (including VMs in scale sets) to pull metrics from Azure Diagnostics Extensision when enabled"
  type        = bool
  default     = false
}

variable "custom_namespaces_per_service" {
  description = "List of maps for which each service key will be synced metrics from associated namespaces in addition to the default namespaces. It provides more fine-grained controle compared to the boolean convenience parameter \"sync_guest_os_namespaces\""
  type = list(object({
    service    = string
    namespaces = list(string)
  }))
  default = null
}

variable "azure_tenant_id" {
  description = "Azure Tenant ID/Directory ID"
  type        = string
}

variable "azure_subscription_ids" {
  description = "List of Azure Subscription IDs to monitor"
  type        = list(string)
}

variable "azure_sp_application_id" {
  description = "Azure Service Principal application ID"
  type        = string
}

variable "azure_sp_application_token" {
  description = "Azure Service Principal application token (or password)"
  type        = string
}

variable "signalfx_token_name" {
  description = "Name of sfx token to use"
  type        = string
  default     = null
}