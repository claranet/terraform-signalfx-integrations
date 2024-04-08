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

variable "namespace_sync_rules_filters" {
  description = "Define a map of filters to apply on included services, each key is the namespace name and values are key values pairs defining default_action, filter_action and filter_source."
  type        = map(any)
  default     = null
}

variable "included_services" {
  description = "List of AWS services to collect metrics for (By default it will collect every supported AWS services)"
  type        = list(string)
  # https://docs.splunk.com/observability/en/gdi/integrations/cloud-aws.html
  default = [
    "AWS/ACMPrivateCA",
    "AWS/AmazonMQ",
    "AWS/ApiGateway",
    "AWS/ApplicationELB",
    "AWS/AppStream",
    "AWS/Athena",
    "AWS/AutoScaling",
    "AWS/Backup",
    "AWS/Billing",
    "AWS/CertificateManager",
    "AWS/CloudFront",
    "AWS/CloudHSM",
    "AWS/CloudSearch",
    "AWS/CodeBuild",
    "AWS/Cognito",
    "AWS/Connect",
    "AWS/DDoSProtection",
    "AWS/DMS",
    "AWS/DocDB",
    "AWS/DX",
    "AWS/DynamoDB",
    "AWS/EBS",
    # ec2 is always monitored by this module
    # and is handled by a dedicated variable ec2_namespace_sync_rule
    # (it's normal it doesn't appear in this list)
    # "AWS/EC2",
    "AWS/EC2Spot",
    "AWS/ECS",
    "AWS/EFS",
    "AWS/EKS",
    "AWS/ElastiCache",
    "AWS/ElasticBeanstalk",
    "AWS/ElasticMapReduce",
    "AWS/ElasticInference",
    "AWS/ElasticTranscoder",
    "AWS/ELB",
    "AWS/ES",
    "AWS/Events",
    "AWS/Firehose",
    "AWS/FSx",
    "AWS/GameLift",
    "AWS/Inspector",
    "AWS/IoT",
    "AWS/IoTAnalytics",
    "AWS/Kafka",
    "AWS/Kinesis",
    "AWS/KinesisAnalytics",
    "AWS/KinesisVideo",
    "AWS/KMS",
    "AWS/Lambda",
    "AWS/Lex",
    "AWS/Logs",
    "AWS/MediaConnect",
    "AWS/MediaConvert",
    "AWS/MediaPackage",
    "AWS/MediaTailor",
    "AWS/ML",
    "AWS/NATGateway",
    "AWS/Neptune",
    "AWS/NetworkELB",
    "AWS/OpsWorks",
    "AWS/Polly",
    "AWS/RDS",
    "AWS/Redshift",
    "AWS/Robomaker",
    "AWS/Route53",
    "AWS/S3",
    "AWS/S3/Storage-Lens",
    "AWS/SageMaker",
    "AWS/SDKMetrics",
    "AWS/SES",
    "AWS/SNS",
    "AWS/SQS",
    "AWS/States",
    "AWS/StorageGateway",
    "AWS/SWF",
    "AWS/Textract",
    "AWS/ThingsGraph",
    "AWS/Translate",
    "AWS/TrustedAdvisor",
    "AWS/VPN",
    "AWS/WAFV2",
    "AWS/WorkMail",
    "AWS/WorkSpaces",
    "CWAgent",
    "Glue",
    "MediaLive",
    "System/Linux",
    "WAF",
  ]
}

variable "extra_included_services" {
  description = "List of AWS services to add to included_services (if you find one is missing from the default list please create a merge requests), check https://docs.splunk.com/Observability/gdi/get-data-in/integrations.html#amazon-web-services"
  type        = list(string)
  default     = []
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

variable "signalfx_token_name" {
  description = "Name of already existing SFX token to use"
  type        = string
  default     = null
}
