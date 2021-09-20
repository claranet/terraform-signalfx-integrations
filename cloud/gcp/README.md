# CLOUD GCP SignalFx integrations

## How to use this module

```hcl
module "signalfx-integrations-cloud-gcp" {
  source                 = "github.com/claranet/terraform-signalfx-integrations.git//cloud/gcp?ref={revision}"

  gcp_project_id         = var.gcp_project
}

```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.26 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 3 |
| <a name="requirement_signalfx"></a> [signalfx](#requirement\_signalfx) | >= 6.5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 3 |
| <a name="provider_signalfx"></a> [signalfx](#provider\_signalfx) | >= 6.5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_project_iam_custom_role.sfx_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_member.sfx_service_account_membership](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.sfx_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_key.sak](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) | resource |
| [signalfx_gcp_integration.gcp_integration](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/gcp_integration) | resource |
| [signalfx_org_token.gcp_integration](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/org_token) | resource |
| [signalfx_gcp_services.gcp_services](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/data-sources/gcp_services) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether the GCP integration is enabled | `bool` | `true` | no |
| <a name="input_gcp_compute_metadata_whitelist"></a> [gcp\_compute\_metadata\_whitelist](#input\_gcp\_compute\_metadata\_whitelist) | List of GCP compute metadata to whitelist for use with the SignalFx GCP integration | `list(string)` | <pre>[<br>  "sfx_env",<br>  "sfx_monitored"<br>]</pre> | no |
| <a name="input_gcp_project_id"></a> [gcp\_project\_id](#input\_gcp\_project\_id) | GCP project id for use with the SignalFx GCP integration | `string` | n/a | yes |
| <a name="input_gcp_service_account_id"></a> [gcp\_service\_account\_id](#input\_gcp\_service\_account\_id) | GCP service account id for use with the SignalFx GCP integration | `string` | `""` | no |
| <a name="input_host_or_usage_limits"></a> [host\_or\_usage\_limits](#input\_host\_or\_usage\_limits) | Specify Usage-based limits for this integration | `map(number)` | `null` | no |
| <a name="input_notifications_limits"></a> [notifications\_limits](#input\_notifications\_limits) | Where to send notifications about this token's limits | `list(string)` | `null` | no |
| <a name="input_poll_rate"></a> [poll\_rate](#input\_poll\_rate) | GCP poll rate in seconds (One of 60 or 300) | `number` | `300` | no |
| <a name="input_services"></a> [services](#input\_services) | GCP service metrics to import. Empty list imports all services | `list(any)` | `[]` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | Optional suffix to identify and avoid duplication of unique resources | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gcp_service_account_id"></a> [gcp\_service\_account\_id](#output\_gcp\_service\_account\_id) | The GCP service account id used by SignalFx |
| <a name="output_signalfx_named_token"></a> [signalfx\_named\_token](#output\_signalfx\_named\_token) | The SignalFx named token used by the GCP integration |
<!-- END_TF_DOCS -->

## Related documentation

[Official documentation](https://docs.signalfx.com/en/latest/integrations/google-cloud-platform.html#connect-to-google-cloud-platform)

## Setup

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
