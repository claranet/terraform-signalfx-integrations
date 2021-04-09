# CLOUD GCP SignalFx integrations

## How to use this module

```hcl
module "signalfx-integrations-cloud-gcp" {
  source                 = "github.com/claranet/terraform-signalfx-integrations.git//cloud/gcp?ref={revision}"

  gcp_project_id         = var.gcp_project
}

```
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.26 |
| google | >= 3 |
| signalfx | >= 4.26.4 |

## Providers

| Name | Version |
|------|---------|
| google | >= 3 |
| signalfx | >= 4.26.4 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [google_project_iam_custom_role](https://registry.terraform.io/providers/hashicorp/google/3/docs/resources/project_iam_custom_role) |
| [google_project_iam_member](https://registry.terraform.io/providers/hashicorp/google/3/docs/resources/project_iam_member) |
| [google_service_account](https://registry.terraform.io/providers/hashicorp/google/3/docs/resources/service_account) |
| [google_service_account_key](https://registry.terraform.io/providers/hashicorp/google/3/docs/resources/service_account_key) |
| [signalfx_gcp_integration](https://registry.terraform.io/providers/splunk-terraform/signalfx/4.26.4/docs/resources/gcp_integration) |
| [signalfx_gcp_services](https://registry.terraform.io/providers/splunk-terraform/signalfx/4.26.4/docs/data-sources/gcp_services) |
| [signalfx_org_token](https://registry.terraform.io/providers/splunk-terraform/signalfx/4.26.4/docs/resources/org_token) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| enabled | Whether the GCP integration is enabled | `bool` | `true` | no |
| gcp\_compute\_metadata\_whitelist | List of GCP compute metadata to whitelist for use with the SignalFx GCP integration | `list(string)` | <pre>[<br>  "sfx_env",<br>  "sfx_monitored"<br>]</pre> | no |
| gcp\_project\_id | GCP project id for use with the SignalFx GCP integration | `string` | n/a | yes |
| gcp\_service\_account\_id | GCP service account id for use with the SignalFx GCP integration | `string` | `""` | no |
| host\_or\_usage\_limits | Specify Usage-based limits for this integration | `map(number)` | `null` | no |
| notifications\_limits | Where to send notifications about this token's limits | `list(string)` | `null` | no |
| poll\_rate | GCP poll rate in seconds (One of 60 or 300) | `number` | `300` | no |
| services | GCP service metrics to import. Empty list imports all services | `list(any)` | `[]` | no |
| suffix | Optional suffix to identify and avoid duplication of unique resources | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| gcp\_service\_account\_id | The GCP service account id used by SignalFx |
| signalfx\_named\_token | The SignalFx named token used by the GCP integration |

## Related documentation

[Official documentation](https://docs.signalfx.com/en/latest/integrations/google-cloud-platform.html#connect-to-google-cloud-platform)

## Requirements

**WARNING:** When the `gcp_service_account_id` parameter is not provided, this module creates a service account and uses the `google_project_iam_member` resource which is not compatible with IAM permissions set externally and authoritatively managed with the `google_project_iam_policy` resource. If you happen to use the `google_project_iam_policy` resource on the provided GCP project,
make sure to provide the `gcp_service_account_id` parameter and ensure the corresponding service account has the appropriate IAM permissions on the GCP project:
 - monitoring.metricDescriptors.get
 - monitoring.metricDescriptors.list
 - monitoring.timeSeries.list
 - resourcemanager.projects.get
 - compute.instances.list
 - compute.machineTypes.list
 - spanner.instances.list
 - storage.buckets.list

You need to configure your GCP and SignalFx providers.
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

variable "gcp_project" {
  type = string
}

provider "google" {
  project = var.gcp_project
}

```

## Notes

* This module will create an organization token and use it for ingesting data from the created GCP integration.
  This allows to distinguish hosts/metrics counts across monitored environments (e.g. staging, preprod, prod) and set specific limits.
* As for any integration configuration you need a [**session**](https://docs.signalfx.com/en/latest/admin-guide/tokens.html#user-api-access-tokens) token from an admin
* You need to be an IAM admin on GCP account
