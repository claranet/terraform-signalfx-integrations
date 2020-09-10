# ALERTING SLACK SignalFx integrations

## How to use this module

```hcl
module "signalfx-integrations-alerting-slack" {
  source  = "github.com/claranet/terraform-signalfx-integrations.git//alerting/slack"

  webhook_url        = var.slack_webhook_url
  slack_channel_name = "my-project-alerts"
}

```

## Providers

| Name | Version |
|------|---------|
| signalfx | ~> 4 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| enabled | Whether the PagerDuty integration is enabled | `bool` | `true` | no |
| slack\_channel\_name | Slack channel on which send the notifications (without #, only used to generated formatted notification output). | `string` | n/a | yes |
| suffix | Optional suffix to identify and avoid duplication of unique resources | `string` | `""` | no |
| webhook\_url | Slack webhook URL | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| sfx\_integration\_id | SignalFx integration ID |
| sfx\_integration\_name | SignalFx integration name |
| sfx\_integration\_notification | SignalFx integration formatted notification |

## Related documentation

* [Official documentation](https://docs.signalfx.com/en/latest/admin-guide/integrate-notifications.html#integrate-with-slack)
* [Slack documentation](https://api.slack.com/messaging/webhooks)

## Requirements

You need to configure SignalFx provider and retrieve a Slack webhook.
Credentials could be set in your `terraform.tfvars`.

```
variable "slack_webhook_url" {
  description = "Slack webhook URL for incoming messages"
  type        = string
}

provider "signalfx" {
  auth_token = var.sfx_token                  # admin temporary session token
  api_url    = "https://api.eu0.signalfx.com" # change for your realm
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
      module.signalfx-integrations-alerting-slack.sfx_integration_notification
    ]
  }
}
```
