# CLOUD AZURE SignalFx integrations

## How to use this module

Enable SignalFX integration:

```hcl
module "signalfx-integrations-cloud-azure" {
  source                 = "github.com/claranet/terraform-signalfx-integrations.git//cloud/azure/sfx?ref={revision}"

  azure_tenant_id        = var.azure_tenant_id
  azure_subscription_ids = [var.azure_subscription_id]

  azure_sp_application_id    = azuread_application.signalfx_integration.application_id
  azure_sp_application_token = azuread_service_principal_password.signalfx_integration_sp_pwd.value
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.26 |
| <a name="requirement_signalfx"></a> [signalfx](#requirement\_signalfx) | >= 6.7.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_signalfx"></a> [signalfx](#provider\_signalfx) | >= 6.7.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [signalfx_azure_integration.azure_integration](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/azure_integration) | resource |
| [signalfx_org_token.azure_integration](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/org_token) | resource |
| [signalfx_azure_services.azure_services](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/data-sources/azure_services) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_sp_application_id"></a> [azure\_sp\_application\_id](#input\_azure\_sp\_application\_id) | Azure Service Principal application ID | `string` | n/a | yes |
| <a name="input_azure_sp_application_token"></a> [azure\_sp\_application\_token](#input\_azure\_sp\_application\_token) | Azure Service Principal application token (or password) | `string` | n/a | yes |
| <a name="input_azure_subscription_ids"></a> [azure\_subscription\_ids](#input\_azure\_subscription\_ids) | List of Azure Subscription IDs to monitor | `list(string)` | n/a | yes |
| <a name="input_azure_tenant_id"></a> [azure\_tenant\_id](#input\_azure\_tenant\_id) | Azure Tenant ID/Directory ID | `string` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether the Azure integration is enabled | `bool` | `true` | no |
| <a name="input_excluded_services"></a> [excluded\_services](#input\_excluded\_services) | List of Azure services to not collect metrics for (removed from the `services` list) | `list(string)` | `[]` | no |
| <a name="input_host_or_usage_limits"></a> [host\_or\_usage\_limits](#input\_host\_or\_usage\_limits) | Specify Usage-based limits for this integration | `map(number)` | `null` | no |
| <a name="input_notifications_limits"></a> [notifications\_limits](#input\_notifications\_limits) | Where to send notifications about this token's limits | `list(string)` | `null` | no |
| <a name="input_poll_rate"></a> [poll\_rate](#input\_poll\_rate) | Azure poll rate in seconds (One of 60 or 300) | `number` | `300` | no |
| <a name="input_services"></a> [services](#input\_services) | Azure service metrics to import. Empty list imports all services | `list(string)` | `[]` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | Optional suffix to identify and avoid duplication of unique resources | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_signalfx_integration_name"></a> [signalfx\_integration\_name](#output\_signalfx\_integration\_name) | The SignalFx integration name for Azure |
| <a name="output_signalfx_integration_poll_rate"></a> [signalfx\_integration\_poll\_rate](#output\_signalfx\_integration\_poll\_rate) | The Azure poll rate configured in the SignalFx integration |
| <a name="output_signalfx_integration_services"></a> [signalfx\_integration\_services](#output\_signalfx\_integration\_services) | The list of Azure services configured in SignalFx integration |
| <a name="output_signalfx_integration_subscriptions"></a> [signalfx\_integration\_subscriptions](#output\_signalfx\_integration\_subscriptions) | The Azure subscriptions ids configured in the SignalFx integration |
| <a name="output_signalfx_integration_tenant"></a> [signalfx\_integration\_tenant](#output\_signalfx\_integration\_tenant) | The Azure tenant id configured in the SignalFx integration |
<!-- END_TF_DOCS -->

## Related documentation

[Official documentation](https://docs.signalfx.com/en/latest/integrations/azure-info.html#connect-to-microsoft-azure)

## Setup

You need to configure your SignalFx providers.
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
```

## Notes

* This module will create an organization token and use it for ingesting data from the created Azure integration.
  This allows to distinguish hosts/metrics counts across monitored environments (e.g. staging, preprod, prod) and set specific limits.
* As for any integration configuration you need a [**session**](https://docs.signalfx.com/en/latest/admin-guide/tokens.html#user-api-access-tokens) token from an admin.
* You need to have an Azure Service Principal created with `Reader` Role granted over the SignalFX scope (ie: all monitored Azure Subscriptions).
