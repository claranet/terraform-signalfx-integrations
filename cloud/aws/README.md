# CLOUD AWS SignalFx integrations

## How to use this module

```hcl
module "signalfx-integrations-cloud-aws" {
  source = "github.com/claranet/terraform-signalfx-integrations.git//cloud/aws?ref={revision}"
}

```

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2 |
| signalfx | ~> 4 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| aws\_regions | List of AWS regions that SignalFx should monitor | `list` | <pre>[<br>  "eu-west-1"<br>]</pre> | no |
| custom\_namespace\_sync\_rule | Each element controls the data collected by SignalFx for the specified namespace | <pre>object({<br>    default_action = string<br>    filter_action  = string<br>    filter_source  = string<br>    namespace      = string<br>  })</pre> | <pre>{<br>  "default_action": null,<br>  "filter_action": null,<br>  "filter_source": null,<br>  "namespace": "*"<br>}</pre> | no |
| enabled | Whether the AWS integration is enabled | `bool` | `true` | no |
| import\_aws\_usage | Import usage metrics from AWS to use with AWS Cost Optimizer | `bool` | `true` | no |
| import\_cloudwatch | Import Cloud Watch metrics from AWS | `bool` | `true` | no |
| namespace\_sync\_rule | Default namespace sync rule with filtering capabilities | <pre>object({<br>    default_action = string<br>    filter_action  = string<br>    filter_source  = string<br>    namespace      = string<br>  })</pre> | <pre>{<br>  "default_action": "Exclude",<br>  "filter_action": "Include",<br>  "filter_source": "filter('aws_tag_sfx_monitored', 'true')",<br>  "namespace": "AWS/EC2"<br>}</pre> | no |
| namespaces | List of default AWS namespaces to sync without any filtering in addition to "namespace\_sync\_rule" | `list` | <pre>[<br>  "AWS/ApiGateway",<br>  "AWS/AppStream",<br>  "AWS/Athena",<br>  "AWS/Billing",<br>  "AWS/ACMPrivateCA",<br>  "AWS/CloudFront",<br>  "AWS/CloudHSM",<br>  "AWS/CloudSearch",<br>  "AWS/Logs",<br>  "AWS/CodeBuild",<br>  "AWS/Cognito",<br>  "AWS/Connect",<br>  "AWS/DMS",<br>  "AWS/DX",<br>  "AWS/DocDB",<br>  "AWS/DynamoDB",<br>  "AWS/EC2Spot",<br>  "AWS/AutoScaling",<br>  "AWS/ElasticBeanstalk",<br>  "AWS/EBS",<br>  "AWS/ECS",<br>  "AWS/EFS",<br>  "AWS/ApplicationELB",<br>  "AWS/ELB",<br>  "AWS/NetworkELB",<br>  "AWS/ElasticTranscoder",<br>  "AWS/ElastiCache",<br>  "AWS/ES",<br>  "AWS/ElasticMapReduce",<br>  "AWS/MediaConnect",<br>  "AWS/MediaConvert",<br>  "AWS/MediaPackage",<br>  "AWS/MediaTailor",<br>  "AWS/Events",<br>  "AWS/FSx",<br>  "AWS/GameLift",<br>  "AWS/Glue",<br>  "AWS/Inspector",<br>  "AWS/IoT",<br>  "AWS/IoTAnalytics",<br>  "AWS/ThingsGraph",<br>  "AWS/KMS",<br>  "AWS/KinesisAnalytics",<br>  "AWS/Firehose",<br>  "AWS/Kinesis",<br>  "AWS/KinesisVideo",<br>  "AWS/Lambda",<br>  "AWS/Lex",<br>  "AWS/ML",<br>  "AWS/Kafka",<br>  "AWS/AmazonMQ",<br>  "AWS/Neptune",<br>  "AWS/OpsWorks",<br>  "AWS/Polly",<br>  "AWS/Redshift",<br>  "AWS/RDS",<br>  "AWS/Route53",<br>  "AWS/SageMaker",<br>  "AWS/SDKMetrics",<br>  "AWS/DDoSProtection",<br>  "AWS/SES",<br>  "AWS/SNS",<br>  "AWS/SQS",<br>  "AWS/S3",<br>  "AWS/SWF",<br>  "AWS/States",<br>  "AWS/StorageGateway",<br>  "AWS/Textract",<br>  "AWS/Translate",<br>  "AWS/TrustedAdvisor",<br>  "AWS/NATGateway",<br>  "AWS/VPN",<br>  "WAF",<br>  "AWS/WorkMail",<br>  "AWS/WorkSpaces"<br>]</pre> | no |
| poll\_rate | AWS poll rate in seconds (One of 60 or 300) | `number` | `300` | no |
| suffix | Optional suffix to identify and avoid duplication of unique resources | `string` | `""` | no |
| use\_get\_metric\_data | Enable the use of Amazon's GetMetricData for collecting metrics | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws\_role\_arn | The role ARN of the SignalFx integration |
| aws\_role\_name | The IAM role name of the SignalFx integration |
| sfx\_external\_id | SignalFx integration external ID |
| sfx\_integration\_id | SignalFx integration ID |

## Related documentation

[Official documentation](https://docs.signalfx.com/en/latest/integrations/amazon-web-services.html#connect-to-aws-cloudwatch)

## Requirements

You need to configure your AWS and SignalFx providers.
Credentials could be set in your `terraform.tfvars`.

```
variable "sfx_token" {
  description = "User API token from an admin on SignalFx organization"
  type        = string
}

provider "signalfx" {
  auth_token = var.sfx_token                  # admin temporary session token
  api_url    = "https://api.eu0.signalfx.com" # change for your realm
}

variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

variable "aws_token" {
  type = string
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token      = var.aws_token
}

```

## Notes

* As for any integration configuration you need a [**session**](https://docs.signalfx.com/en/latest/admin-guide/tokens.html#user-api-access-tokens) token from an admin
* You need to be an IAM admin on AWS account
* The first apply could fail with error `is not authorized to perform: sts:AssumeRole on resource:` when AWS signalfx integration is configured before the policy attachment to IAM role from AWS side that it is actualy available
* This module does not support `services` and `custom_cloudwatch_namespaces` because `namespace_sync_rule` and `custom_namespace_sync_rule` are respectively more powerful
* `namespace_sync_rule` is definable from two variables: `namespace_sync_rule` which allows one entire rule configuration (default is filtering on EC2 while it impacts the billing) and `namespaces` which provide a list a namespaces to include but not filter (default is every other AWS namespaces)
