# CLOUD AWS Cloudwatch Metric Stream SignalFx integrations

## How to use this module

```hcl
variable "var.sfx_access_token" {
  type = string
}

variable "var.sfx_ingest_url" {
  type = string
}

module "signalfx-integrations-cloud-aws-cloudwatch-metric-stream" {
  source = "github.com/claranet/terraform-signalfx-integrations.git//cloud/aws-cloudwatch-metric-stream?ref={revision}"

  sfx_access_token = var.sfx_access_token
  sfx_ingest_url = var.sfx_ingest_url
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.sfx_metric_stream](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_stream.http_log_stream](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream) | resource |
| [aws_iam_policy.sfx_cloudwatch_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.sfx_firehose_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.sfx_cloudwatch_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.sfx_firehose_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.sfx_cloudwatch_policy_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.sfx_firehose_policy_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kinesis_firehose_delivery_stream.sfx_metric_stream](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_firehose_delivery_stream) | resource |
| [aws_s3_bucket.sfx_metric_stream](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.sfx_cloudwatch_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sfx_cloudwatch_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sfx_firehose_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sfx_firehose_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_log_group_retention_in_days"></a> [cloudwatch\_log\_group\_retention\_in\_days](#input\_cloudwatch\_log\_group\_retention\_in\_days) | AWS CloudWatch log group retention in days | `number` | `14` | no |
| <a name="input_sfx_access_token"></a> [sfx\_access\_token](#input\_sfx\_access\_token) | Access token used to push metrics to SignalFx | `string` | n/a | yes |
| <a name="input_sfx_ingest_url"></a> [sfx\_ingest\_url](#input\_sfx\_ingest\_url) | Ingest URL used to push metrics to SignalFx | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Related documentation

[Official documentation](https://docs.splunk.com/Observability/gdi/get-data-in/connect/aws/aws-wizardconfig.html#enable-cloudwatch-metric-streams)

## Setup

You need to configure your AWS provider:

```
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
  default = "eu-west-1"
  type     = string
}
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token      = var.aws_token
  region     = var.aws_region
}

# Optional - example of configuration in multiple regions

## we declare a new provider in a different region than the default (un-aliased) one
provider "aws" {
  alias = "us-west-1"

  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token      = var.aws_token
  region     = "us-west-1"
}

## we import again this module but passing explicitly the provider for the other region
module "signalfx-integrations-cloud-aws-cloudwatch-metric-stream-us-west-1" {
  providers = {
    aws = aws.us-west-1
  }

  source = "github.com/claranet/terraform-signalfx-integrations.git//cloud/aws-cloudwatch-metric-stream?ref={revision}"
  sfx_access_token = var.sfx_access_token
  sfx_ingest_url = var.sfx_ingest_url
}
```

## Notes

- This module will create the AWS Cloudwatch Log Group, S3 bucket and Kinesis Data Firehose resources necessary for ingesting AWS Cloudwatch Metric Streams.
- It must be deployed in each AWS region where you want to get metrics from.
- It is usually used in conjonction with the main [aws](https://github.com/claranet/terraform-signalfx-integrations/tree/master/cloud/aws) module. When that's the case, you can pass the `signalfx_org_token` output from the `aws` module directly in the `sfx_access_token` of the `aws-cloudwatch-metric-stream` module.
