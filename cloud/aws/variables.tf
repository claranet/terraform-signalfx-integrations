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

variable "use_get_metric_data" {
  description = "Enable the use of Amazon's GetMetricData for collecting metrics"
  type        = bool
  default     = true
}

variable "excluded_services" {
  description = "List of AWS services to not collect metrics for (do not add an include namespace_sync_rule)"
  type = list
  # These services retrieved from aws services data source raise error at plan:
  # > Not valid namespaces: [AWS/RoboMaker, AWS/MediaLive]
  # they will probably work in future version of the provider (tested was v6.6.0)
  default = ["AWS/RoboMaker", "AWS/MediaLive"]
}

variable "custom_namespace_sync_rule" {
  description = "Each element controls the data collected by SignalFx for the specified namespace"
  type = object({
    default_action = string
    filter_action  = string
    filter_source  = string
    namespace      = string
  })
  default = {
    default_action = null
    filter_action  = null
    filter_source  = null
    namespace      = "*"
  }
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

