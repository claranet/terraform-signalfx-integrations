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
| [signalfx_webhook_integration.sfx_integration](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/webhook_integration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_headers"></a> [additional\_headers](#input\_additional\_headers) | Any additional headers to send | `map(any)` | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether the Webhook integration is enabled | `bool` | `true` | no |
| <a name="input_host_severity"></a> [host\_severity](#input\_host\_severity) | Host severity value as explained in our internal documentation | `string` | n/a | yes |
| <a name="input_notification_period"></a> [notification\_period](#input\_notification\_period) | Notification period (either 24x7 or 8x5) | `string` | n/a | yes |
| <a name="input_relkon_token"></a> [relkon\_token](#input\_relkon\_token) | Relkon API token | `string` | n/a | yes |
| <a name="input_relkon_url"></a> [relkon\_url](#input\_relkon\_url) | Relkon API endpoint | `string` | n/a | yes |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | Webhook name suffix, will precede the notif period | `string` | `"relkon"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sfx_integration_id"></a> [sfx\_integration\_id](#output\_sfx\_integration\_id) | SignalFx integration ID |
| <a name="output_sfx_integration_name"></a> [sfx\_integration\_name](#output\_sfx\_integration\_name) | SignalFx integration name |
| <a name="output_sfx_integration_notification"></a> [sfx\_integration\_notification](#output\_sfx\_integration\_notification) | SignalFx integration formatted notification |
<!-- END_TF_DOCS -->

## Related documentation

* [Official documentation](https://docs.signalfx.com/en/latest/admin-guide/integrate-notifications.html#send-notifications-via-a-webhook-url)

## Setup

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

## Detector example

```
resource "signalfx_detector" "my_detector" {
  // Detector stuff

  rule {
    description : "rule description"
    severity      = "Severity"
    detect_label  = "Detector Label ..."
    notifications = [
      module.signalfx-integrations-alerting-relkon.sfx_integration_notification
    ]
  }
}
```
