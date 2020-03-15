# Global

variable "suffix" {
  description = "Optional suffix to identify and avoid duplication of unique resources"
  type        = string
  default     = ""
}

# AWS Integration specific

variable "enabled" {
  description = "Whether the AWS integration is enabled"
  default     = "true"
}

variable "poll_rate" {
  description = "AWS poll rate in seconds (60 or 300)"
  default     = 300
}

variable "aws_regions" {
  description = "List of AWS regions that SignalFx should monitor"
  default     = ["eu-west-1"]
}

variable "import_cloudwatch" {
  description = "Import Cloud Watch metrics from AWS"
  default     = "true"
}

variable "import_aws_usage" {
  description = "Import usage metrics from AWS to use with AWS Cost Optimizer"
  default     = "true"
}

variable "custom_namespace_rules_default_action" {
  description = "How SignalFx processes data from a custom AWS namespace when there is no filters (Include or Exclude)"
  default     = "Exclude"
}

variable "custom_namespace_rules_filter_action" {
  description = "How SignalFx processes data from a custom AWS namespace for filters (Include or Exclude)"
  default     = "Include"
}

variable "custom_namespace_rules_filter_source" {
  description = "SignalFlow filter() function that selects the data that SignalFx should sync for the custom namespace associated with this sync rule"
  default     = "filter('code', '200')"
}

variable "custom_namespace_rules_namespace" {
  description = "An AWS custom namespace having custom AWS metrics that you want to sync with SignalFx"
  default     = "AWS/ApiGateway"
}

# (Optional) Each element in the array is an object that contains an AWS namespace name and a filter that controls the data that SignalFx collects for the namespace. Conflicts with the services property. If you don't specify either property, SignalFx syncs all data in all AWS namespaces.

variable "namespace_rules_default_action" {
  description = "How SignalFx processes data from default AWS namespace when there is no filters (Include or Exclude)"
  default     = "Exclude"
}

variable "namespace_rules_filter_action" {
  description = "How SignalFx processes data from a default AWS namespace for filters (Include or Exclude)"
  default     = "Include"
}

variable "namespace_rules_filter_source" {
  description = "SignalFlow filter() function that selects the data that SignalFx should sync for default AWS namespace associated with this sync rule"
  default     = ""
}

variable "namespace_rules_list" {
  description = "List of default AWS namespaces having AWS metrics that you want to sync with SignalFx"
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

variable "namespace_rules_ec2" {
  description = "EC2 default AWS namespace having AWS metrics that you want to sync with SignalFx"
  default     = "AWS/EC2"
}

variable "namespace_rules_filter_source_ec2" {
  description = "SignalFlow filter() function that whitelist or blacklist specific tags for EC2 to avoid overbilling"
  default     = "filter('aws_tag_claranet_monitored', 'true')"
}
