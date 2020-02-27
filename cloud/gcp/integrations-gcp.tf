resource "random_id" "service_account_name" {
  count       = var.gcp_service_account_id == "" ? 1 : 0
  byte_length = 4
  prefix      = "signalfx-integration-"
}

data "google_service_account" "sfx_service_account" {
  count      = var.gcp_service_account_id != "" ? 1 : 0
  account_id = var.gcp_service_account_id
  project    = var.gcp_project_id
}

resource "google_service_account" "sfx_service_account" {
  count        = var.gcp_service_account_id == "" ? 1 : 0
  account_id   = lower(random_id.service_account_name[0].hex)
  display_name = "SignalFX integration"
  project      = var.gcp_project_id
}

locals {
  project_roles = [
    "roles/cloudasset.viewer",
    "roles/compute.viewer",
    "roles/container.viewer",
    "roles/monitoring.viewer",
  ]

  id_to_use = length(data.google_service_account.sfx_service_account) > 0 ? data.google_service_account.sfx_service_account[0].id : google_service_account.sfx_service_account[0].id
}

resource "google_service_account_key" "sak" {
  service_account_id = local.id_to_use
}

resource "google_project_iam_member" "sfx_service_account_membership" {
  for_each = toset(var.gcp_service_account_id == "" ? local.project_roles : [])

  project = var.gcp_project_id
  role    = each.value
  member  = "serviceAccount:${local.id_to_use}"
}

locals {
  decoded_private_key = jsondecode(base64decode(google_service_account_key.sak.private_key))
}

resource "signalfx_gcp_integration" "gcp_claranet_integration" {
	name = "GCP - Claranet"
	enabled = true
	poll_rate = 300
	project_service_keys {
		project_id = local.decoded_private_key["project_id"]
		project_key = local.decoded_private_key["private_key"]
	}

  depends_on = [google_project_iam_member.sfx_service_account_membership]
}
