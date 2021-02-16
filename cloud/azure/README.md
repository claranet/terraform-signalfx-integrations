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

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.26 |
| azuread | >= 1.1 |
| azurerm | >= 2 |
| signalfx | >= 4.26.4 |

## Providers

| Name | Version |
|------|---------|
| azuread | >= 1.1 |
| azurerm | >= 2 |
| random | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| sfx-integration | ./sfx |  |

## Resources

| Name |
|------|
| [azuread_application](https://registry.terraform.io/providers/hashicorp/azuread/1.1/docs/resources/application) |
| [azuread_service_principal](https://registry.terraform.io/providers/hashicorp/azuread/1.1/docs/resources/service_principal) |
| [azuread_service_principal_password](https://registry.terraform.io/providers/hashicorp/azuread/1.1/docs/resources/service_principal_password) |
| [azurerm_role_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/2/docs/resources/role_assignment) |
| [random_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azure\_sp\_validation\_time | Relative duration for which the Password is valid until, for example `240h` (10 days) or `2400h30m`. Valid time units are "ns", "us" (or "µs"), "ms", "s", "m", "h".<br>  Changing this field forces a new resource to be created | `string` | `"17520h"` | no |
| azure\_subscription\_ids | List of Azure Subscription IDs to monitor | `list(string)` | n/a | yes |
| azure\_tenant\_id | Azure Tenant ID/Directory ID | `string` | n/a | yes |
| enabled | Whether the Azure integration is enabled | `bool` | `true` | no |
| poll\_rate | Azure poll rate in seconds (One of 60 or 300) | `number` | `300` | no |
| services | Azure service metrics to import. Empty list imports all services | `list(string)` | `[]` | no |
| suffix | Optional suffix to identify and avoid duplication of unique resources | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| azure\_ad\_sp\_app\_id | The Azure Service Principal App ID of the SignalFx integration |
| azure\_ad\_sp\_object\_id | The Azure Service Principal Object ID of the SignalFx integration |
| azure\_ad\_sp\_secret\_key | The Azure Service Principal secret key of the SignalFx integration |
| signalfx\_integration\_name | The SignalFx integration name for Azure |
| signalfx\_integration\_poll\_rate | The Azure poll rate configured in the SignalFx integration |
| signalfx\_integration\_services | The list of Azure services configured in SignalFx integration |
| signalfx\_integration\_subscriptions | The Azure subscriptions ids configured in the SignalFx integration |
| signalfx\_integration\_tenant | The Azure tenant id configured in the SignalFx integration |

## Related documentation

[Official documentation](https://docs.signalfx.com/en/latest/integrations/azure-info.html#connect-to-microsoft-azure)

## Requirements

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

* This module will create an organization token and use it for ingesting data from the created GCP integration.
  This allows to distinguish hosts/metrics counts across monitored environments (e.g. staging, preprod, prod) and set specific limits.
* As for any integration configuration you need a [**session**](https://docs.signalfx.com/en/latest/admin-guide/tokens.html#user-api-access-tokens) token from an admin.
* You need to be an AAD Applications Administrator and Owner on all Azure Subscriptions to monitor.

