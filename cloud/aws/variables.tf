# Global

variable "suffix" {
  description = "Optional suffix to identify and avoid duplication of unique resources"
  type        = string
  default     = ""
}

# AWS Integration specific

variable "enabled" {
  description = "Whether the AWS integration is enabled"
  type        = bool
  default     = true
}

variable "poll_rate" {
  description = "AWS poll rate in seconds (One of 60 or 300)"
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

variable "aws_regions" {
  description = "List of AWS regions that SignalFx should monitor"
  type        = list(any)
  default     = ["eu-west-1"]
}

variable "import_cloudwatch" {
  description = "Import Cloud Watch metrics from AWS"
  type        = bool
  default     = true
}

variable "import_aws_usage" {
  description = "Import usage metrics from AWS to use with AWS Cost Optimizer"
  type        = bool
  default     = false
}

variable "enable_check_large_volume" {
  description = "Enable monitoring of the amount of data coming in from the integration"
  type        = bool
  default     = false
}

variable "enable_logs_sync" {
  description = "Enable the AWS logs synchronization. When setting it to `true`, you also need to set `create_logs_iam` to `true`"
  type        = bool
  default     = false
}

variable "create_logs_iam" {
  description = "Enable the creation of the IAM role required to enable Amazon's Cloudwatch Logs sync. This is separate from the `enable_logs_sync` parameter as disabling Logs still requires the existence of the IAM role"
  type        = bool
  default     = false
}

variable "use_get_metric_data" {
  description = "Enable the use of Amazon's GetMetricData for collecting metrics"
  type        = bool
  default     = true
}

variable "use_metric_streams_sync" {
  description = "Enable the use of Amazon's Cloudwatch Metric Streams for ingesting metrics. When setting it to `true`, you also need to set `create_metric_streams_iam` to `true`"
  type        = bool
  default     = false
}

variable "create_metric_streams_iam" {
  description = "Enable the creation of the IAM role required to enable Amazon's Cloudwatch Metric Streams for ingesting metrics. This is separate from the `use_metric_streams_sync` parameter as disabling Metric Streams still requires the existence of the IAM role"
  type        = bool
  default     = false
}

variable "excluded_services" {
  description = "List of AWS services to not collect metrics for (do not add an include namespace_sync_rule)"
  type        = list(any)
  default     = []
}

variable "custom_namespace_sync_rules" {
  description = "List where each element is a rule which controls the data collected by SignalFx for the specified namespace"
  type = list(object({
    default_action = string
    filter_action  = string
    filter_source  = string
    namespace      = string
  }))
  default = null
}

variable "ec2_namespace_sync_rule" {
  description = "Default namespace sync rule with filtering capabilities"
  type = object({
    default_action = string
    filter_action  = string
    filter_source  = string
    namespace      = string
  })
  default = {
    default_action = "Exclude"
    filter_action  = "Include"
    filter_source  = "filter('aws_tag_sfx_monitored', 'true')"
    namespace      = "AWS/EC2"
  }
}

variable "metrics_stats_to_sync" {
  description = "List of objects defining namespace, metric and stats to change the standard set of statistics retrieved by integration by specific ones. Useful to fetch statistics not available by default like percentile"
  type = list(object({
    namespace = string
    metric    = string
    stats     = list(string)
  }))
  default = null
}

