# CLOUD GCP SignalFx integrations

## How to use this module

```hcl
module "signalfx-integrations-cloud-gcp" {
  source                 = "git@github.com/claranet/terraform-signalfx-integrations.git//cloud/gcp?ref={revision}"

  gcp_project_id         = var.gcp_project
}

```

## Providers

| Name | Version |
|------|---------|
| google | ~> 3 |
| signalfx | ~> 4 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| enabled | Whether the GCP integration is enabled | `bool` | `true` | no |
| gcp\_project\_id | GCP project id for use with the SignalFx GCP integration | `string` | n/a | yes |
| gcp\_service\_account\_id | GCP service account id for use with the SignalFx GCP integration | `string` | `""` | no |
| poll\_rate | GCP poll rate in seconds (One of 60 or 300) | `number` | `300` | no |
| services | GCP service metrics to import. Empty list imports all services | `list` | `[]` | no |
| suffix | Optional suffix to identify and avoid duplication of unique resources | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| gcp\_service\_account\_id | The GCP service account id used by SignalFx |

## Related documentation

[Official documentation](https://docs.signalfx.com/en/latest/integrations/google-cloud-platform.html#connect-to-google-cloud-platform)

## Requirements

You need to configure your GCP and SignalFx providers.
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

variable "gcp_project" {
  type = string
}

provider "google" {
  project = var.gcp_project
}

```

## Notes

* As for any integration configuration you need a [**session**](https://docs.signalfx.com/en/latest/admin-guide/tokens.html#user-api-access-tokens) token from an admin
* You need to be an IAM admin on GCP account
