# CLOUD AWS SignalFx integrations

## How to use this module

```hcl
module "signalfx-integrations-cloud-aws" {
  source = "github.com/claranet/terraform-signalfx-integrations.git//cloud/aws?ref={revision}"
}

```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |
| <a name="requirement_signalfx"></a> [signalfx](#requirement\_signalfx) | >= 8.1.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.9.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.12.0 |
| <a name="provider_signalfx"></a> [signalfx](#provider\_signalfx) | 8.1.0 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.9.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.sfx_logs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.sfx_metric_streams_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.sfx_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.sfx_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.sfx_logs_policy_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.sfx_metric_streams_policy_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.sfx_policy_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [signalfx_aws_external_integration.aws_integration_external](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/aws_external_integration) | resource |
| [signalfx_aws_integration.aws_integration](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/aws_integration) | resource |
| [signalfx_org_token.aws_integration](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/org_token) | resource |
| [time_sleep.logs_policy_availability](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.policy_availability](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [aws_iam_policy_document.sfx_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_regions"></a> [aws\_regions](#input\_aws\_regions) | List of AWS regions that SignalFx should monitor | `list(any)` | <pre>[<br>  "eu-west-1"<br>]</pre> | no |
| <a name="input_create_logs_iam"></a> [create\_logs\_iam](#input\_create\_logs\_iam) | Enable the creation of the IAM role required to enable Amazon's Cloudwatch Logs sync. This is separate from the `enable_logs_sync` parameter as disabling Logs still requires the existence of the IAM role | `bool` | `false` | no |
| <a name="input_create_metric_streams_iam"></a> [create\_metric\_streams\_iam](#input\_create\_metric\_streams\_iam) | Enable the creation of the IAM role required to enable Amazon's Cloudwatch Metric Streams for ingesting metrics. This is separate from the `use_metric_streams_sync` parameter as disabling Metric Streams still requires the existence of the IAM role | `bool` | `false` | no |
| <a name="input_custom_namespace_sync_rules"></a> [custom\_namespace\_sync\_rules](#input\_custom\_namespace\_sync\_rules) | List where each element is a rule which controls the data collected by SignalFx for the specified namespace | <pre>list(object({<br>    default_action = string<br>    filter_action  = string<br>    filter_source  = string<br>    namespace      = string<br>  }))</pre> | `null` | no |
| <a name="input_ec2_namespace_sync_rule"></a> [ec2\_namespace\_sync\_rule](#input\_ec2\_namespace\_sync\_rule) | Default namespace sync rule with filtering capabilities | <pre>object({<br>    default_action = string<br>    filter_action  = string<br>    filter_source  = string<br>    namespace      = string<br>  })</pre> | <pre>{<br>  "default_action": "Exclude",<br>  "filter_action": "Include",<br>  "filter_source": "filter('aws_tag_sfx_monitored', 'true')",<br>  "namespace": "AWS/EC2"<br>}</pre> | no |
| <a name="input_enable_check_large_volume"></a> [enable\_check\_large\_volume](#input\_enable\_check\_large\_volume) | Enable monitoring of the amount of data coming in from the integration | `bool` | `false` | no |
| <a name="input_enable_logs_sync"></a> [enable\_logs\_sync](#input\_enable\_logs\_sync) | Enable the AWS logs synchronization. When setting it to `true`, you also need to set `create_logs_iam` to `true` | `bool` | `false` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether the AWS integration is enabled | `bool` | `true` | no |
| <a name="input_excluded_services"></a> [excluded\_services](#input\_excluded\_services) | List of AWS services to not collect metrics for (do not add an include namespace\_sync\_rule) | `list(any)` | `[]` | no |
| <a name="input_extra_included_services"></a> [extra\_included\_services](#input\_extra\_included\_services) | List of AWS services to add to included\_services (if you find one is missing from the default list please create a merge requests), check https://docs.splunk.com/Observability/gdi/get-data-in/integrations.html#amazon-web-services | `list(string)` | `[]` | no |
| <a name="input_host_or_usage_limits"></a> [host\_or\_usage\_limits](#input\_host\_or\_usage\_limits) | Specify Usage-based limits for this integration | `map(number)` | `null` | no |
| <a name="input_import_aws_usage"></a> [import\_aws\_usage](#input\_import\_aws\_usage) | Import usage metrics from AWS to use with AWS Cost Optimizer | `bool` | `false` | no |
| <a name="input_import_cloudwatch"></a> [import\_cloudwatch](#input\_import\_cloudwatch) | Import Cloud Watch metrics from AWS | `bool` | `true` | no |
| <a name="input_included_services"></a> [included\_services](#input\_included\_services) | List of AWS services to collect metrics for (By default it will collect every supported AWS services) | `list(string)` | <pre>[<br>  "AWS/ACMPrivateCA",<br>  "AWS/AmazonMQ",<br>  "AWS/ApiGateway",<br>  "AWS/ApplicationELB",<br>  "AWS/AppStream",<br>  "AWS/Athena",<br>  "AWS/AutoScaling",<br>  "AWS/Backup",<br>  "AWS/Billing",<br>  "AWS/CertificateManager",<br>  "AWS/CloudFront",<br>  "AWS/CloudHSM",<br>  "AWS/CloudSearch",<br>  "AWS/CodeBuild",<br>  "AWS/Cognito",<br>  "AWS/Connect",<br>  "AWS/DDoSProtection",<br>  "AWS/DMS",<br>  "AWS/DocDB",<br>  "AWS/DX",<br>  "AWS/DynamoDB",<br>  "AWS/EBS",<br>  "AWS/EC2Spot",<br>  "AWS/ECS",<br>  "AWS/EFS",<br>  "AWS/EKS",<br>  "AWS/ElastiCache",<br>  "AWS/ElasticBeanstalk",<br>  "AWS/ElasticInterface",<br>  "AWS/ElasticMapReduce",<br>  "AWS/ElasticTranscoder",<br>  "AWS/ELB",<br>  "AWS/ES",<br>  "AWS/Events",<br>  "AWS/Firehose",<br>  "AWS/FSx",<br>  "AWS/GameLift",<br>  "AWS/Inspector",<br>  "AWS/IoT",<br>  "AWS/IoTAnalytics",<br>  "AWS/Kafka",<br>  "AWS/Kinesis",<br>  "AWS/KinesisAnalytics",<br>  "AWS/KinesisVideo",<br>  "AWS/KMS",<br>  "AWS/Lambda",<br>  "AWS/Lex",<br>  "AWS/Logs",<br>  "AWS/MediaConnect",<br>  "AWS/MediaConvert",<br>  "AWS/MediaPackage",<br>  "AWS/MediaTailor",<br>  "AWS/ML",<br>  "AWS/NATGateway",<br>  "AWS/Neptune",<br>  "AWS/NetworkELB",<br>  "AWS/OpsWorks",<br>  "AWS/Polly",<br>  "AWS/RDS",<br>  "AWS/Redshift",<br>  "AWS/Robomaker",<br>  "AWS/Route53",<br>  "AWS/S3",<br>  "AWS/S3/Storage-Lens",<br>  "AWS/SageMaker",<br>  "AWS/SDKMetrics",<br>  "AWS/SES",<br>  "AWS/SNS",<br>  "AWS/SQS",<br>  "AWS/States",<br>  "AWS/StorageGateway",<br>  "AWS/SWF",<br>  "AWS/Textract",<br>  "AWS/ThingsGraph",<br>  "AWS/Translate",<br>  "AWS/TrustedAdvisor",<br>  "AWS/VPN",<br>  "AWS/WAFV2",<br>  "AWS/WorkMail",<br>  "AWS/WorkSpaces",<br>  "CWAgent",<br>  "Glue",<br>  "MediaLive",<br>  "System/Linux",<br>  "WAF"<br>]</pre> | no |
| <a name="input_metrics_stats_to_sync"></a> [metrics\_stats\_to\_sync](#input\_metrics\_stats\_to\_sync) | List of objects defining namespace, metric and stats to change the standard set of statistics retrieved by integration by specific ones. Useful to fetch statistics not available by default like percentile | <pre>list(object({<br>    namespace = string<br>    metric    = string<br>    stats     = list(string)<br>  }))</pre> | `null` | no |
| <a name="input_namespace_sync_rules_filters"></a> [namespace\_sync\_rules\_filters](#input\_namespace\_sync\_rules\_filters) | Define a map of filters to apply on included services, each key is the namespace name and values are key values pairs defining default\_action, filter\_action and filter\_source. | `map(any)` | `null` | no |
| <a name="input_notifications_limits"></a> [notifications\_limits](#input\_notifications\_limits) | Where to send notifications about this token's limits | `list(string)` | `null` | no |
| <a name="input_poll_rate"></a> [poll\_rate](#input\_poll\_rate) | AWS poll rate in seconds (One of 60 or 300) | `number` | `300` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | Optional suffix to identify and avoid duplication of unique resources | `string` | `""` | no |
| <a name="input_use_metric_streams_sync"></a> [use\_metric\_streams\_sync](#input\_use\_metric\_streams\_sync) | Enable the use of Amazon's Cloudwatch Metric Streams for ingesting metrics. When setting it to `true`, you also need to set `create_metric_streams_iam` to `true` | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_integration_id"></a> [aws\_integration\_id](#output\_aws\_integration\_id) | SignalFx integration ID |
| <a name="output_aws_role_arn"></a> [aws\_role\_arn](#output\_aws\_role\_arn) | The role ARN of the SignalFx integration |
| <a name="output_aws_role_name"></a> [aws\_role\_name](#output\_aws\_role\_name) | The IAM role name of the SignalFx integration |
| <a name="output_sfx_external_id"></a> [sfx\_external\_id](#output\_sfx\_external\_id) | SignalFx integration external ID |
| <a name="output_signalfx_org_token"></a> [signalfx\_org\_token](#output\_signalfx\_org\_token) | Org token for ingesting data from AWS integration |
<!-- END_TF_DOCS -->

## Related documentation

[Official documentation](https://docs.signalfx.com/en/latest/integrations/amazon-web-services.html#connect-to-aws-cloudwatch)

## Setup

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

variable "aws_region" {
  type = string
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token      = var.aws_token
  region     = var.aws_region
}

```

## Notes

- This module will create an organization token and use it for ingesting data from the created AWS integration.
  This allows to distinguish hosts/metrics counts across monitored environments (e.g. staging, preprod, prod) and set specific limits.
- As for any integration configuration you need a [**session**](https://docs.signalfx.com/en/latest/admin-guide/tokens.html#user-api-access-tokens) token from an admin
- You need to be an IAM admin on AWS account
- The apply will wait between the AWS policy attachment to role and the signalfx aws integration creation to prevent permission denied error
- This module does not support `services` and `custom_cloudwatch_namespaces` because `namespace_sync_rule` and `custom_namespace_sync_rule` are respectively more powerful but in conflict

### CloudWatch Metric Streams

- When enabling AWS Cloudwatch Metric Streams with `use_metric_streams_sync = true`, you also need to set `create_metric_streams_iam` to `true`. Then you need to create the Kinesis Data Firehose resources by yourself in each of the regions where you want to collect metrics from. You can use the [`aws-cloudwatch-metric-stream`](https://github.com/claranet/terraform-signalfx-integrations/tree/master/cloud/aws-cloudwatch-metric-stream) module to do this.
- When disabling AWS Cloudwatch Metric Streams, make sure to apply in two phases:
  - first change the `use_metric_streams_sync` parameter from `true` to `false` and run `terraform apply` to let it deprovision the AWS Cloudwatch Metric Streams resources it created,
  - then change `create_metric_streams_iam` from `true` to `false` and run `terraform apply` to destroy the IAM role.
    If you do not follow that process, the AWS integration will end up in `CANCELATION_FAILED` status.

Note: filtering metrics on tags does not work with Metric Streams, so the default filter on the `aws_tag_sfx_monitored` tag is not used. This can increase your SignalFX licensing costs when switching from pull based ingestion to push if not all EC2 hosts have to be monitored in an AWS account.

### CloudWatch Logs sync (BETA)

- When enabling AWS Cloudwatch Logs sync with `enable_logs_sync = true`, you also need to set `create_logs_iam` to `true`. 
- When disabling AWS Cloudwatch Logs, make sure to apply in two phases:
  - first change the `enable_logs_sync` parameter from `true` to `false` and run `terraform apply`
  - then change `create_logs_iam` from `true` to `false` and run `terraform apply` to destroy the IAM role.

### Namespaces filtering

The filtering behavior of this module is voluntarily opinionated and could be compared to iptables rules:

- a `namespace_sync_rule` will be added to include everything for all supported services
- **except** for `AWS/EC2` namespace and all namespaces defined in the `excluded_services` list variable
- a special `namespace_sync_rule` will be added for `AWS/EC2` to include metrics from instances where tags match the filter `aws_tag_sfx_monitored:true` as described in [this
  documentation](https://github.com/claranet/terraform-signalfx-detectors/wiki/Tagging-convention#goal)
- and all metrics which do not match any of previous "including" rules will be "excluded" from collection

It allows to avoid being billed for undesirable AWS EC2 instances but you can override this rule using `ec2_namespace_sync_rule` variable.

Feel free to override `excluded_services` list to prevent collection of **any** metrics from specific services (as
[services](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/aws_integration#services) does natively).

If there is any default value set for `excluded_services` this is probably because they are returned by the [data
source](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/data-sources/aws_services) but not yet supported for configuration of the integration.
You can try to remove them and if you do not get error like `Not valid namespaces: [AWS/RoboMaker, AWS/MediaLive]` please open pull request to remove them from the default value.

Instead of filtering out every service you do not want to get metrics from, you can only include the services you need. You can also filter the metrics to fetch for each namespace. This is useful to reduce the number of MTS and to reduce AWS CloudWatch costs.

```
included_services = [
  "AWS/ELB",
  "AWS/ApplicationELB",
  "AWS/RDS",
  "AWS/ElastiCache",
  "AWS/ES"
]

namespace_sync_rules_filters = {
  "AWS/ELB" = {
    default_action = "Exclude"
    filter_action  = "Include"
    filter_source = "filter('sf_metric','Latency','HTTPCode_ELB_5XX','RequestCount','HTTPCode_ELB_4XX','HTTPCode_Backend_5XX','HTTPCode_Backend_4XX','HealthyHostCount','UnHealthyHostCount')"
  }
}
```
