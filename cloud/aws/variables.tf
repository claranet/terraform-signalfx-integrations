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
  type        = list
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
  default     = true
}

variable "use_get_metric_data" {
  description = "Enable the use of Amazon's GetMetricData for collecting metrics"
  type        = bool
  default     = true
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

variable "namespace_sync_rule" {
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

variable "namespaces" {
  description = "List of default AWS namespaces to sync without any filtering in addition to \"namespace_sync_rule\""
  type        = list
  default = [
    #    "AWS/Cassandra",
    "AWS/ApiGateway",
    "AWS/AppStream",
    #    "AWS/AppSync",
    "AWS/Athena",
    "AWS/Billing",
    "AWS/ACMPrivateCA",
    #    "AWS/Chatbot",
    "AWS/CloudFront",
    "AWS/CloudHSM",
    "AWS/CloudSearch",
    "AWS/Logs",
    "AWS/CodeBuild",
    "AWS/Cognito",
    "AWS/Connect",
    #    "AWS/DataSync",
    "AWS/DMS",
    "AWS/DX",
    "AWS/DocDB",
    "AWS/DynamoDB",
    "AWS/EC2Spot",
    "AWS/AutoScaling",
    "AWS/ElasticBeanstalk",
    "AWS/EBS",
    "AWS/ECS",
    "AWS/EFS",
    #    "AWS/ElasticInference",
    "AWS/ApplicationELB",
    "AWS/ELB",
    "AWS/NetworkELB",
    "AWS/ElasticTranscoder",
    "AWS/ElastiCache",
    "AWS/ES",
    "AWS/ElasticMapReduce",
    "AWS/MediaConnect",
    "AWS/MediaConvert",
    "AWS/MediaPackage",
    "AWS/MediaTailor",
    "AWS/Events",
    "AWS/FSx",
    "AWS/GameLift",
    "AWS/Glue",
    "AWS/Inspector",
    "AWS/IoT",
    "AWS/IoTAnalytics",
    "AWS/ThingsGraph",
    "AWS/KMS",
    "AWS/KinesisAnalytics",
    "AWS/Firehose",
    "AWS/Kinesis",
    "AWS/KinesisVideo",
    "AWS/Lambda",
    "AWS/Lex",
    "AWS/ML",
    "AWS/Kafka",
    "AWS/AmazonMQ",
    "AWS/Neptune",
    "AWS/OpsWorks",
    "AWS/Polly",
    #    "AWS/QLDB",
    "AWS/Redshift",
    "AWS/RDS",
    #    "AWS/Robomaker",
    "AWS/Route53",
    "AWS/SageMaker",
    "AWS/SDKMetrics",
    #    "AWS/ServiceCatalog",
    "AWS/DDoSProtection",
    "AWS/SES",
    "AWS/SNS",
    "AWS/SQS",
    "AWS/S3",
    "AWS/SWF",
    "AWS/States",
    "AWS/StorageGateway",
    #    "AWS/SSM-RunCommand",
    "AWS/Textract",
    #    "AWS/Transfer",
    "AWS/Translate",
    "AWS/TrustedAdvisor",
    "AWS/NATGateway",
    #    "AWS/TransitGateway",
    "AWS/VPN",
    "WAF",
    "AWS/WorkMail",
    "AWS/WorkSpaces"
  ]
}

