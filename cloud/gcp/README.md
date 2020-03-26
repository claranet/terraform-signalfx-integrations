# CLOUD GCP SignalFx integrations

## How to use this module

```hcl
module "signalfx-integrations-cloud-gcp" {
  source = "git::ssh://git@github.com/claranet/terraform-signalfx-integrations.git//cloud/gcp?ref={revision}"

  gcp_project_id         = var.gcp_project_id
}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| enabled | Whether the GCP integration is enabled | `string` | `"true"` | no |
| gcp\_project\_id | GCP project id for use with the SignalFx GCP integration | `string` | n/a | yes |
| gcp\_service\_account\_id | GCP service account id for use with the SignalFx GCP integration | `string` | `""` | no |
| poll\_rate | GCP poll rate in seconds (One of 60 or 300) | `number` | `300` | no |
| suffix | Optional suffix to identify and avoid duplication of unique resources | `string` | `""` | no |

## Outputs

No output.

## Related documentation

[Official documentation](https://docs.signalfx.com/en/latest/integrations/google-cloud-platform.html#connect-to-google-cloud-platform)

## Requirements

You need to configure your GCP provider.
Credentials could be set in your `terraform.tfvars`.

```
variable "gcp_project" {
  type = string
}

provider "google" {
  version = "~> 2"

  project = var.gcp_project
}
```

## Notes

* As for any integration configuration you need a **session** token from your SignalFx user (and not an **org** access token)
