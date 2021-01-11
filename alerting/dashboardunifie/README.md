# ALERTING UnifiedDashboard SignalFx integrations

## How to use this module

```hcl
module "signalfx-integrations-alerting-dashboardunifie" {
  source  = "github.com/claranet/terraform-signalfx-integrations.git//alerting/dashboardunifie"

  dashboardunifie_url          = var.dashboardunifie_url
  username                     = "user"
  password                     = "password"
  project_id                   = "MyID"
}

```

## Providers

| Name | Version |
|------|---------|
| signalfx | ~> 4 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_headers | Any additional headers to send | `map` | `{}` | no |
| enabled | Whether the Webhook integration is enabled | `bool` | `true` | no |
| username | username for dashboard | `string` | n/a | yes |
| password | password for dashboard | `string` | n/a | yes |
| dashboardunifie\_url | DashboardUnifie API endpoint | `string` | n/a | yes |
| project\_id | project ID to identify the project | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| sfx\_integration\_id | SignalFx integration ID |
| sfx\_integration\_name | SignalFx integration name |
| sfx\_integration\_notification | SignalFx integration formatted notification |

## Related documentation

* [Official documentation](https://docs.signalfx.com/en/latest/admin-guide/integrate-notifications.html#send-notifications-via-a-webhook-url)

## Requirements

You need to configure SignalFx provider and retrieve a DashboardUnifie token.

```
variable "sfx_token" {
  description = "User API token from an admin on SignalFx organization"
  type        = string
}

provider "signalfx" {
  auth_token = var.sfx_token                  # admin temporary session token
  api_url    = "https://api.eu0.signalfx.com" # change for your realm
}

variable "dashboardunifie_token" {
  description = "The dashboardunifie token specific to your client"
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
      module.signalfx-integrations-alerting-dashboardunifie.sfx_integration_notification
    ]
  }
}
```
