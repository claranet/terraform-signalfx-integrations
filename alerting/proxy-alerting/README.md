# ALERTING Proxy-Alerting SignalFx integrations

## How to use this module

```hcl
module "signalfx-integrations-alerting-proxy-alerting" {
  source  = "github.com/claranet/terraform-signalfx-integrations.git//alerting/proxy-alerting"

  url        = var.proxy_alerting_url
  username   = "user"
  password   = var.proxy_alerting_password
  project_id = "MyID"
}

```

## Providers

| Name | Version |
|------|---------|
| signalfx | ~> 4 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_headers | Any additional headers to send | `map(any)` | `{}` | no |
| enabled | Whether the Webhook integration is enabled | `bool` | `true` | no |
| password | The proxy-alerting password to authentificate | `string` | n/a | yes |
| project\_id | Project ID to add to the project-id header | `string` | `null` | no |
| suffix | Webhook name suffix, will precede the notif period | `string` | `"proxy-alerting"` | no |
| url | The proxy-alerting URL to use | `string` | `"https://proxy-alerting.fr.clara.net/api/signalfx"` | no |
| username | The proxy-alerting username to authentificate | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| sfx\_integration\_id | SignalFx integration ID |
| sfx\_integration\_name | SignalFx integration name |
| sfx\_integration\_notification | SignalFx integration formatted notification |

## Related documentation

* [Official documentation](https://docs.signalfx.com/en/latest/admin-guide/integrate-notifications.html#send-notifications-via-a-webhook-url)

## Requirements

You need to configure SignalFx provider and retrieve a proxy-alerting token.

```
variable "sfx_token" {
  description = "User API token from an admin on SignalFx organization"
  type        = string
}

provider "signalfx" {
  auth_token = var.sfx_token                  # admin temporary session token
  api_url    = "https://api.eu0.signalfx.com" # change for your realm
}

variable "proxy_alerting_password" {
  description = "The proxy-alerting password to authentificate"
  type        = string
}

```

## Notes

* As for any integration configuration you need a **session** token from your SignalFx user (and not an **org** access token)

## Detector example

```
resource "signalfx_detector" "my_detector" {
  // Detector stuff

  rule {
    description : "rule description"
    severity      = "Severity"
    detect_label  = "Detector Label ..."
    notifications = [
      module.signalfx-integrations-alerting-proxy-alerting.sfx_integration_notification
    ]
  }
}
```
