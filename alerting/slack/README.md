# ALERTING SLACK SignalFx integrations

## How to use this module

```hcl
module "signalfx-integrations-alerting-slack" {
  source  = "github.com/claranet/terraform-signalfx-integrations.git//alerting/slack"

  webhook_url        = var.slack_webhook_url
  slack_channel_name = "my-project-alerts"
}

```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.26 |
| <a name="requirement_signalfx"></a> [signalfx](#requirement\_signalfx) | >= 4.26.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_signalfx"></a> [signalfx](#provider\_signalfx) | >= 4.26.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [signalfx_slack_integration.sfx_integration](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/slack_integration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether the PagerDuty integration is enabled | `bool` | `true` | no |
| <a name="input_slack_channel_name"></a> [slack\_channel\_name](#input\_slack\_channel\_name) | Slack channel on which send the notifications (without #, only used to generated formatted notification output). | `string` | n/a | yes |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | Optional suffix to identify and avoid duplication of unique resources | `string` | `""` | no |
| <a name="input_webhook_url"></a> [webhook\_url](#input\_webhook\_url) | Slack webhook URL | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sfx_integration_id"></a> [sfx\_integration\_id](#output\_sfx\_integration\_id) | SignalFx integration ID |
| <a name="output_sfx_integration_name"></a> [sfx\_integration\_name](#output\_sfx\_integration\_name) | SignalFx integration name |
| <a name="output_sfx_integration_notification"></a> [sfx\_integration\_notification](#output\_sfx\_integration\_notification) | SignalFx integration formatted notification |
<!-- END_TF_DOCS -->

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
