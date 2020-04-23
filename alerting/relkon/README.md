# ALERTING RELKON SignalFx integrations

## How to use this module

```hcl
module "signalfx-integrations-alerting-relkon" {
  source  = "github.com/claranet/terraform-signalfx-integrations.git//alerting/relkon"

  relkon_url          = var.relkon_url
  relkon_token        = var.relkon_token
  notification_period = var.notification_period
  host_severity       = 30 # Change it according to your needs and the relkon API documentation
}

```

## Providers

| Name | Version |
|------|---------|
| signalfx | ~> 4 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| additional\_headers | Any additional headers to send | map | `{}` | no |
| enabled | Whether the Webhook integration is enabled | bool | `"true"` | no |
| host\_severity | Host severity value as explained in our internal documentation | string | n/a | yes |
| notification\_period | Notification period \(either 24x7 or 8x5\) | string | n/a | yes |
| relkon\_token | Relkon API token | string | n/a | yes |
| relkon\_url | Relkon API endpoint | string | n/a | yes |
| suffix | Webhook name suffix, will precede the notif period | string | `"relkon"` | no |

## Outputs

| Name | Description |
|------|-------------|
| sfx\_webhook\_id | SignalFx webhook ID |

## Related documentation

[Official documentation](https://docs.signalfx.com/en/latest/admin-guide/integrate-notifications.html#send-notifications-via-a-webhook-url)

## Requirements

You need to configure SignalFx provider and retrieve a Relkon token.

```
variable "sfx_token" {
  description = "User API token from an admin on SignalFx organization"
  type        = string
}

provider "signalfx" {
  auth_token = var.sfx_token                  # admin temporary session token
  api_url    = "https://api.eu0.signalfx.com" # change for your realm
}

variable "relkon_token" {
  description = "The relkon token specific to your client"
  type        = string
}

```

## Notes

* As for any integration configuration you need a **session** token from your SignalFx user (and not an **org** access token)
