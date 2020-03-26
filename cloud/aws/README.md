# CLOUD AWS SignalFx integrations

## How to use this module

```hcl
module "signalfx-integrations-cloud-aws" {
  source = "git::ssh://git@github.com/claranet/terraform-signalfx-integrations.git//cloud/aws?ref={revision}"
}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| aws\_regions | List of AWS regions that SignalFx should monitor | `list` | <pre>[<br>  "eu-west-1"<br>]</pre> | no |
| custom\_namespace\_rules\_default\_action | How SignalFx processes data from a custom AWS namespace when there is no filters (Include or Exclude) | `string` | `"Exclude"` | no |
| custom\_namespace\_rules\_filter\_action | How SignalFx processes data from a custom AWS namespace for filters (Include or Exclude) | `string` | `"Include"` | no |
| custom\_namespace\_rules\_filter\_source | SignalFlow filter() function that selects the data that SignalFx should sync for the custom namespace associated with this sync rule | `string` | `"filter('code', '200')"` | no |
| custom\_namespace\_rules\_namespace | An AWS custom namespace having custom AWS metrics that you want to sync with SignalFx | `string` | `"AWS/ApiGateway"` | no |
| enabled | Whether the AWS integration is enabled | `string` | `"true"` | no |
| import\_aws\_usage | Import usage metrics from AWS to use with AWS Cost Optimizer | `string` | `"true"` | no |
| import\_cloudwatch | Import Cloud Watch metrics from AWS | `string` | `"true"` | no |
| namespace\_rules\_default\_action | How SignalFx processes data from default AWS namespace when there is no filters (Include or Exclude) | `string` | `"Exclude"` | no |
| namespace\_rules\_ec2 | EC2 default AWS namespace having AWS metrics that you want to sync with SignalFx | `string` | `"AWS/EC2"` | no |
| namespace\_rules\_filter\_action | How SignalFx processes data from a default AWS namespace for filters (Include or Exclude) | `string` | `"Include"` | no |
| namespace\_rules\_filter\_source | SignalFlow filter() function that selects the data that SignalFx should sync for default AWS namespace associated with this sync rule | `string` | `""` | no |
| namespace\_rules\_filter\_source\_ec2 | SignalFlow filter() function that whitelist or blacklist specific tags for EC2 to avoid overbilling | `string` | `"filter('aws_tag_claranet_monitored', 'true')"` | no |
| namespace\_rules\_list | List of default AWS namespaces having AWS metrics that you want to sync with SignalFx | `list` | <pre>[<br>  "AWS/ApiGateway",<br>  "AWS/AppStream",<br>  "AWS/Athena",<br>  "AWS/Billing",<br>  "AWS/ACMPrivateCA",<br>  "AWS/CloudFront",<br>  "AWS/CloudHSM",<br>  "AWS/CloudSearch",<br>  "AWS/Logs",<br>  "AWS/CodeBuild",<br>  "AWS/Cognito",<br>  "AWS/Connect",<br>  "AWS/DMS",<br>  "AWS/DX",<br>  "AWS/DocDB",<br>  "AWS/DynamoDB",<br>  "AWS/EC2Spot",<br>  "AWS/AutoScaling",<br>  "AWS/ElasticBeanstalk",<br>  "AWS/EBS",<br>  "AWS/ECS",<br>  "AWS/EFS",<br>  "AWS/ApplicationELB",<br>  "AWS/ELB",<br>  "AWS/NetworkELB",<br>  "AWS/ElasticTranscoder",<br>  "AWS/ElastiCache",<br>  "AWS/ES",<br>  "AWS/ElasticMapReduce",<br>  "AWS/MediaConnect",<br>  "AWS/MediaConvert",<br>  "AWS/MediaPackage",<br>  "AWS/MediaTailor",<br>  "AWS/Events",<br>  "AWS/FSx",<br>  "AWS/GameLift",<br>  "AWS/Glue",<br>  "AWS/Inspector",<br>  "AWS/IoT",<br>  "AWS/IoTAnalytics",<br>  "AWS/ThingsGraph",<br>  "AWS/KMS",<br>  "AWS/KinesisAnalytics",<br>  "AWS/Firehose",<br>  "AWS/Kinesis",<br>  "AWS/KinesisVideo",<br>  "AWS/Lambda",<br>  "AWS/Lex",<br>  "AWS/ML",<br>  "AWS/Kafka",<br>  "AWS/AmazonMQ",<br>  "AWS/Neptune",<br>  "AWS/OpsWorks",<br>  "AWS/Polly",<br>  "AWS/Redshift",<br>  "AWS/RDS",<br>  "AWS/Route53",<br>  "AWS/SageMaker",<br>  "AWS/SDKMetrics",<br>  "AWS/DDoSProtection",<br>  "AWS/SES",<br>  "AWS/SNS",<br>  "AWS/SQS",<br>  "AWS/S3",<br>  "AWS/SWF",<br>  "AWS/States",<br>  "AWS/StorageGateway",<br>  "AWS/Textract",<br>  "AWS/Translate",<br>  "AWS/TrustedAdvisor",<br>  "AWS/NATGateway",<br>  "WAF",<br>  "AWS/WorkMail",<br>  "AWS/WorkSpaces"<br>]</pre> | no |
| poll\_rate | AWS poll rate in seconds (60 or 300) | `number` | `300` | no |
| suffix | Optional suffix to identify and avoid duplication of unique resources | `string` | `""` | no |

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

You need to configure your AWS provider.
Credentials could be set in your `terraform.tfvars`.

```
variable "aws_region" {
  type = string
}

variable "aws_account" {
  type = string
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
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token      = var.aws_token
}

```

## Notes

* As for any integration configuration you need a **session** token from your SignalFx user (and not an **org** access token)
* You need to be an IAM admin on AWS account
* The first apply could fail with error `is not authorized to perform: sts:AssumeRole on resource:` when AWS signalfx integration is configured before the policy attachment to IAM role from AWS side that it is actualy available

