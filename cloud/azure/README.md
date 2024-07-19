# CLOUD AZURE SignalFx integrations

## How to use this module

Generate both Azure SP resources and SignalFX integration:

```hcl
module "signalfx-integrations-cloud-azure" {
  source                 = "github.com/claranet/terraform-signalfx-integrations.git//cloud/azure?ref={revision}"

  azure_tenant_id        = var.azure_tenant_id
  azure_subscription_ids = [var.azure_subscription_id]
}
```

Enable only SignalFX integration:

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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 2.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.1 |
| <a name="requirement_signalfx"></a> [signalfx](#requirement\_signalfx) | ~> 6.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | ~> 2.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sfx_integration"></a> [sfx\_integration](#module\_sfx\_integration) | ./sfx | n/a |

## Resources

| Name | Type |
|------|------|
| [azuread_application.signalfx_integration](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_service_principal.signalfx_integration_sp](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_service_principal_password.signalfx_integration_sp_pwd](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal_password) | resource |
| [azurerm_role_assignment.signalfx_integration_sp_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_services"></a> [additional\_services](#input\_additional\_services) | Not yet officially supported Azure resource types to sync with SignalFx as custom metrics | `list(string)` | `null` | no |
| <a name="input_azure_spn_token_validity_duration"></a> [azure\_spn\_token\_validity\_duration](#input\_azure\_spn\_token\_validity\_duration) | Azure Service Principal token/password duration before it expires. Defaults to 2 years. Notation documentation: https://pkg.go.dev/time#ParseDuration | `string` | `"17520h"` | no |
| <a name="input_azure_subscription_ids"></a> [azure\_subscription\_ids](#input\_azure\_subscription\_ids) | List of Azure Subscription IDs to monitor | `list(string)` | n/a | yes |
| <a name="input_azure_tenant_id"></a> [azure\_tenant\_id](#input\_azure\_tenant\_id) | Azure Tenant ID/Directory ID | `string` | n/a | yes |
| <a name="input_custom_namespaces_per_service"></a> [custom\_namespaces\_per\_service](#input\_custom\_namespaces\_per\_service) | List of maps for which each service key will be synced metrics from associated namespaces in addition to the default namespaces. It provides more fine-grained controle compared to the boolean convenience parameter "sync\_guest\_os\_namespaces" | <pre>list(object({<br>    service    = string<br>    namespaces = list(string)<br>  }))</pre> | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether the Azure integration is enabled | `bool` | `true` | no |
| <a name="input_excluded_services"></a> [excluded\_services](#input\_excluded\_services) | List of Azure services to not collect metrics for (removed from the `services` list) | `list(string)` | `[]` | no |
| <a name="input_host_or_usage_limits"></a> [host\_or\_usage\_limits](#input\_host\_or\_usage\_limits) | Specify Usage-based limits for this integration | `map(number)` | `null` | no |
| <a name="input_notifications_limits"></a> [notifications\_limits](#input\_notifications\_limits) | Where to send notifications about this token's limits | `list(string)` | `null` | no |
| <a name="input_poll_rate"></a> [poll\_rate](#input\_poll\_rate) | Azure poll rate in seconds (One of 60 or 300) | `number` | `300` | no |
| <a name="input_resource_filter_rules"></a> [resource\_filter\_rules](#input\_resource\_filter\_rules) | List of rules for filtering Azure resources by their tags. Each filter follows "filter('key', 'value')". Referenced keys are limited to tags and must start with the "azure\_tag\_" prefix | <pre>list(object({<br>    filter = object({<br>      source = string<br>    })<br>  }))</pre> | `null` | no |
| <a name="input_services"></a> [services](#input\_services) | Azure service metrics to import. Empty list imports all services | `list(string)` | `[]` | no |
| <a name="input_signalfx_token_name"></a> [signalfx\_token\_name](#input\_signalfx\_token\_name) | Name of already existing SFX token to use | `string` | `null` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | Optional suffix to identify and avoid duplication of unique resources | `string` | `""` | no |
| <a name="input_sync_guest_os_namespaces"></a> [sync\_guest\_os\_namespaces](#input\_sync\_guest\_os\_namespaces) | Sync additional namespaces for VMs (including VMs in scale sets) to pull metrics from Azure Diagnostics Extensision when enabled | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_ad_sp_app_id"></a> [azure\_ad\_sp\_app\_id](#output\_azure\_ad\_sp\_app\_id) | The Azure Service Principal App ID of the SignalFx integration |
| <a name="output_azure_ad_sp_object_id"></a> [azure\_ad\_sp\_object\_id](#output\_azure\_ad\_sp\_object\_id) | The Azure Service Principal Object ID of the SignalFx integration |
| <a name="output_azure_ad_sp_secret_key"></a> [azure\_ad\_sp\_secret\_key](#output\_azure\_ad\_sp\_secret\_key) | The Azure Service Principal secret key of the SignalFx integration |
| <a name="output_azure_ad_sp_validity_end_date"></a> [azure\_ad\_sp\_validity\_end\_date](#output\_azure\_ad\_sp\_validity\_end\_date) | The Azure Service Principal validity date of the SignalFx integration |
| <a name="output_signalfx_integration_name"></a> [signalfx\_integration\_name](#output\_signalfx\_integration\_name) | The SignalFx integration name for Azure |
| <a name="output_signalfx_integration_poll_rate"></a> [signalfx\_integration\_poll\_rate](#output\_signalfx\_integration\_poll\_rate) | The Azure poll rate configured in the SignalFx integration |
| <a name="output_signalfx_integration_services"></a> [signalfx\_integration\_services](#output\_signalfx\_integration\_services) | The list of Azure services configured in SignalFx integration |
| <a name="output_signalfx_integration_subscriptions"></a> [signalfx\_integration\_subscriptions](#output\_signalfx\_integration\_subscriptions) | The Azure subscriptions ids configured in the SignalFx integration |
| <a name="output_signalfx_integration_tenant"></a> [signalfx\_integration\_tenant](#output\_signalfx\_integration\_tenant) | The Azure tenant id configured in the SignalFx integration |
<!-- END_TF_DOCS -->

## Related documentation

[Official documentation](https://docs.signalfx.com/en/latest/integrations/azure-info.html#connect-to-microsoft-azure)

## Setup

You need to configure your Azure and SignalFx providers.
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

variable "azure_subscription_id" {
  type = string
}

variable "azure_tenant_id" {
  type = string
}

provider "azurerm" {
  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id
  features {}
  #skip_provider_registration = true
}

provider "azuread" {
  tenant_id = var.azure_tenant_id
}

```

## Notes

* This module will create an organization token and use it for ingesting data from the created Azure integration.
  This allows to distinguish hosts/metrics counts across monitored environments (e.g. staging, preprod, prod) and set specific limits.
* As for any integration configuration you need a [**session**](https://docs.signalfx.com/en/latest/admin-guide/tokens.html#user-api-access-tokens) token from an admin.
* You need to be an AAD Applications Administrator and Owner on all Azure Subscriptions to monitor.
