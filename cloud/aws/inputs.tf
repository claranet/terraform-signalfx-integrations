# AWS Integration specific

variable "enable_flag" {
  description = "(Required) Whether the integration is enabled"
  default = "true"
}

variable "aws_regions" {
  description = "(Optional) List of AWS regions that SignalFx should monitor."
  default = ["eu-west-1"]
}

variable "aws_poll_rate" {
  description = "(Optional) AWS poll rate (in seconds). One of 60 or 300."
  default = 300
}

variable "import_cloud_watch_flag" {
  description = "(Optional) Flag that controls how SignalFx imports Cloud Watch metrics. If true, SignalFx imports Cloud Watch metrics from AWS."
  default = "true"
}

variable "enable_aws_usage_flag" {
  description = "(Optional) Flag that controls how SignalFx imports usage metrics from AWS to use with AWS Cost Optimizer. If true, SignalFx imports the metrics."
  default = "true"
}

# (Optional) Each element controls the data collected by SignalFx for the specified namespace. Note: conflicts with the custom_cloudwatch_namespaces property.

variable "custom_namespace_rules_default_action" {
  description = "(Required) Controls the SignalFx default behavior for processing data from an AWS namespace. If you do specify a filter, use this property to control how SignalFx treats data that doesn't match the filter. The available actions are one of Include or Exclude."
  default = "Exclude"
}

variable "custom_namespace_rules_filter_action" {
  description = "(Required) Controls how SignalFx processes data from a custom AWS namespace. The available actions are one of Include or Exclude."
  default = "Include"
}

variable "custom_namespace_rules_filter_source" {
  description = "(Required) Expression that selects the data that SignalFx should sync for the custom namespace associated with this sync rule. The expression uses the syntax defined for the SignalFlow filter() function; it can be any valid SignalFlow filter expression."
  default = "filter('code', '200')"
}

variable "custom_namespace_rules_namespace" {
  description = "(Required) An AWS custom namespace having custom AWS metrics that you want to sync with SignalFx. See the AWS documentation on publishing metrics for more information."
  default = "AWS/ApiGateway"
}

# (Optional) Each element in the array is an object that contains an AWS namespace name and a filter that controls the data that SignalFx collects for the namespace. Conflicts with the services property. If you don't specify either property, SignalFx syncs all data in all AWS namespaces.

variable "namespace_rules_default_action" {
  description = "(Required) Controls the SignalFx default behavior for processing data from an AWS namespace. If you do specify a filter, use this property to control how SignalFx treats data that doesn't match the filter. The available actions are one of Include or Exclude."
  default = "Exclude"
}

variable "namespace_rules_filter_action" {
  description = "(Required) Controls how SignalFx processes data from a AWS namespace. The available actions are one of Include or Exclude."
  default = "Include"
}

variable "namespace_rules_filter_source" {
  description = "(Required) Expression that selects the data that SignalFx should sync for the namespace associated with this sync rule. The expression uses the syntax defined for the SignalFlow filter() function; it can be any valid SignalFlow filter expression."
  default = "filter('code', '200')"
}

variable "namespace_rules_namespace" {
  description = "(Required) An AWS namespace having AWS metrics that you want to sync with SignalFx. See the AWS documentation on publishing metrics for more information."
  default = "AWS/EC2"
}
