# CLOUD AWS SignalFx integrations

## How to use this module

```hcl
module "signalfx-integrations-cloud-aws" {
  source = "github.com/claranet/terraform-signalfx-integrations.git//cloud/aws?ref={revision}"
}

```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.26 |
| aws | >= 2 |
| signalfx | >= 4.26.4 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2 |
| signalfx | >= 4.26.4 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/2/docs/resources/iam_policy) |
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/2/docs/data-sources/iam_policy_document) |
| [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/2/docs/resources/iam_role) |
| [aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/2/docs/resources/iam_role_policy_attachment) |
| [signalfx_aws_external_integration](https://registry.terraform.io/providers/splunk-terraform/signalfx/4.26.4/docs/resources/aws_external_integration) |
| [signalfx_aws_integration](https://registry.terraform.io/providers/splunk-terraform/signalfx/4.26.4/docs/resources/aws_integration) |
| [signalfx_aws_services](https://registry.terraform.io/providers/splunk-terraform/signalfx/4.26.4/docs/data-sources/aws_services) |
| [signalfx_org_token](https://registry.terraform.io/providers/splunk-terraform/signalfx/4.26.4/docs/resources/org_token) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_regions | List of AWS regions that SignalFx should monitor | `list(any)` | <pre>[<br>  "eu-west-1"<br>]</pre> | no |
| custom\_namespace\_sync\_rule | Each element controls the data collected by SignalFx for the specified namespace | <pre>object({<br>    default_action = string<br>    filter_action  = string<br>    filter_source  = string<br>    namespace      = string<br>  })</pre> | <pre>{<br>  "default_action": null,<br>  "filter_action": null,<br>  "filter_source": null,<br>  "namespace": "*"<br>}</pre> | no |
| ec2\_namespace\_sync\_rule | Default namespace sync rule with filtering capabilities | <pre>object({<br>    default_action = string<br>    filter_action  = string<br>    filter_source  = string<br>    namespace      = string<br>  })</pre> | <pre>{<br>  "default_action": "Exclude",<br>  "filter_action": "Include",<br>  "filter_source": "filter('aws_tag_sfx_monitored', 'true')",<br>  "namespace": "AWS/EC2"<br>}</pre> | no |
| enabled | Whether the AWS integration is enabled | `bool` | `true` | no |
| excluded\_services | List of AWS services to not collect metrics for (do not add an include namespace\_sync\_rule) | `list` | <pre>[<br>  "AWS/RoboMaker",<br>  "AWS/MediaLive"<br>]</pre> | no |
| import\_aws\_usage | Import usage metrics from AWS to use with AWS Cost Optimizer | `bool` | `false` | no |
| import\_cloudwatch | Import Cloud Watch metrics from AWS | `bool` | `true` | no |
| poll\_rate | AWS poll rate in seconds (One of 60 or 300) | `number` | `300` | no |
| suffix | Optional suffix to identify and avoid duplication of unique resources | `string` | `""` | no |
| use\_get\_metric\_data | Enable the use of Amazon's GetMetricData for collecting metrics | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws\_integration\_id | SignalFx integration ID |
| aws\_role\_arn | The role ARN of the SignalFx integration |
| aws\_role\_name | The IAM role name of the SignalFx integration |
| sfx\_external\_id | SignalFx integration external ID |

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

* This module will create an organization token and use it for ingesting data from the created AWS integration.
  This allows to distinguish hosts/metrics counts across monitored environments (e.g. staging, preprod, prod) and set specific limits.
* As for any integration configuration you need a [**session**](https://docs.signalfx.com/en/latest/admin-guide/tokens.html#user-api-access-tokens) token from an admin
* You need to be an IAM admin on AWS account
* The first apply could fail with error `is not authorized to perform: sts:AssumeRole on resource:` when AWS signalfx integration is configured before the policy attachment to IAM role from AWS side that it is actualy available
* This module does not support `services` and `custom_cloudwatch_namespaces` because `namespace_sync_rule` and `custom_namespace_sync_rule` are respectively more powerful but in conflict

### Namespaces filtering

The filtering behavior of this module is voluntarily opinionated and could be compared to iptables rules:

- a `namespace_sync_rule` will be added to include everything for all supported services 
- __except__ for `AWS/EC2` namespace and all namespaces defined in the `excluded_services` list variable
- a special `namespace_sync_rule` will be added for `AWS/EC2` to include metrics from instances where tags match the filter `aws_tag_sfx_monitored:true` as described in [this 
documentation](https://github.com/claranet/terraform-signalfx-detectors/wiki/Tagging-convention#goal)
- and all metrics which do not match any of previous "including" rules will be "excluded" from collection

It allows to avoid being billed for undesirable AWS EC2 instances but you can override this rule using `ec2_namespace_sync_rule` variable.

Feel free to override `excluded_services` list to prevent collection of __any__ metrics from specific services (as 
[services](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/aws_integration#services) does natively).

If there is any default value set for `excluded_services` this is probably because they are returned by the [data 
source](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/data-sources/aws_services) but not yet supported for configuration of the integration.
You can try to remove them and if you do not get error like `Not valid namespaces: [AWS/RoboMaker, AWS/MediaLive]` please open pull request to remove them from the default value.
