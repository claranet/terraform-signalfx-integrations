# SignalFx Azure Integration


## Usage

```hcl
terraform {
  required_version = ">= 0.12"
  required_providers {
    azurerm  = "~> 1.44"
    azuread  = "~> 0.7"
    signalfx = "~> 4.16"
  }
}

provider "azurerm" {
  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id
}

provider "azuread" {
  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id
}

variable "sfx_token" {
  type = string
}

provider "signalfx" {
  auth_token = var.sfx_token
  api_url    = "https://api.eu0.signalfx.com"
}

module "signalfx-integrations-cloud-azure" {
  source                 = "git::ssh://git@github.com/claranet/terraform-signalfx-integrations.git//cloud/azure"
  azure_tenant_id        = var.azure_tenant_id
  azure_subscription_ids = [var.azure_subscription_id]
}

```

## Providers

| Name | Version |
|------|---------|
| azuread | ~> 0.7 |
| azurerm | ~> 1.44 |
| signalfx | ~> 4 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| azure\_sp\_validation\_time | Relative duration for which the Password is valid until, for example `240h` (10 days) or `2400h30m`. Valid time units are "ns", "us" (or "µs"), "ms", "s", "m", "h".   Changing this field forces a new resource to be created | `string` | `"17520h"` | no |
| azure\_subscription\_ids | List of Azure Subscription IDs to monitor | `list(string)` | n/a | yes |
| azure\_tenant\_id | Azure Tenant ID/Directory ID | `string` | n/a | yes |
| custom\_sfx\_integration\_name | SignalFx integration custom resource name | `string` | `""` | no |
| enabled | Flag that controls whether the integration is enabled | `bool` | `true` | no |
| poll\_rate | Poll rate (in seconds). One of 60 or 300. | `number` | `60` | no |
| sfx\_integration\_name\_suffix | SignalFx Integration name suffix | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| azure\_ad\_sp\_app\_id | The Azure Service Principal App ID of the SignalFx integration |
| azure\_ad\_sp\_object\_id | The Azure Service Principal Object ID of the SignalFx integration |
