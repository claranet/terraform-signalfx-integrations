# ALERTING Proxy-Alerting SignalFx integrations

## How to use this module

```hcl
module "signalfx-integrations-alerting-proxy-alerting" {
  source  = "github.com/claranet/terraform-signalfx-integrations.git//alerting/proxy-alerting"

  url        = var.proxy_alerting_url
  username   = var.proxy_alerting_username
  password   = var.proxy_alerting_password
  project_id = var.proxy_alerting_synapps_project_id
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
| <a name="input_password"></a> [password](#input\_password) | The proxy-alerting password to authentificate | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID to add to the project-id header | `string` | `null` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | Webhook name suffix, will precede the notif period | `string` | `"proxy-alerting"` | no |
| <a name="input_url"></a> [url](#input\_url) | The proxy-alerting URL to use | `string` | `"https://proxy-alerting.fr.clara.net/api/signalfx"` | no |
| <a name="input_username"></a> [username](#input\_username) | The proxy-alerting username to authentificate | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sfx_integration_id"></a> [sfx\_integration\_id](#output\_sfx\_integration\_id) | SignalFx integration ID |
| <a name="output_sfx_integration_name"></a> [sfx\_integration\_name](#output\_sfx\_integration\_name) | SignalFx integration name |
| <a name="output_sfx_integration_notification"></a> [sfx\_integration\_notification](#output\_sfx\_integration\_notification) | SignalFx integration formatted notification |
<!-- END_TF_DOCS -->

## Related documentation

* [Official documentation](https://docs.signalfx.com/en/latest/admin-guide/integrate-notifications.html#send-notifications-via-a-webhook-url)

## Requirements

You need to configure SignalFx provider and retrieve a proxy-alerting Auth.

```
variable "sfx_token" {
  description = "User API token from an admin on SignalFx organization"
  type        = string
}

provider "signalfx" {
  auth_token = var.sfx_token                  # admin temporary session token
  api_url    = "https://api.eu0.signalfx.com" # change for your realm
}

variable "proxy_alerting_username" {
  description = "The proxy-alerting username to authentificate"
  type        = string
}

variable "proxy_alerting_password" {
  description = "The proxy-alerting password to authentificate"
  type        = string
}

variable "proxy_alerting_synapps_project_id" {
  description = "The Synapps Project ID"
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
