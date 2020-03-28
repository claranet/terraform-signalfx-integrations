# ALERTING PAGERDUTY SignalFx integrations

## How to use this module

```hcl
module "signalfx-integrations-alerting-pagerduty" {
  source  = "github.com/claranet/terraform-signalfx-integrations.git//alerting/pagerduty"

  api_key = var.pagerduty_integration_key
}

```

## Providers

| Name | Version |
|------|---------|
| signalfx | ~> 4 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| api\_key | Pagerduty API token | `string` | n/a | yes |
| enabled | Whether the PagerDuty integration is enabled | `bool` | `true` | no |
| suffix | Optional suffix to identify and avoid duplication of unique resources | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| sfx\_integration\_id | SignalFx integration ID |

## Related documentation

[Official documentation](https://docs.signalfx.com/en/latest/admin-guide/integrate-notifications.html#integrate-with-pagerduty)
[Pagerduty documentation](https://www.pagerduty.com/docs/guides/signalfx-integration-guide/)

## Requirements

You need to configure SignalFx provider and retrieve a PagerDuty integration key.
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

variable "pagerduty_integration_key" {
  type = string
}

```

## Notes

* As for any integration configuration you need a **session** token from your SignalFx user (and not an **org** access token)
