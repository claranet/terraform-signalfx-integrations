data "google_service_account" "sfx_service_account" {
  count      = var.gcp_service_account_id != "" ? 1 : 0
  account_id = var.gcp_service_account_id
}

resource "google_service_account" "sfx_service_account" {
  count        = var.gcp_service_account_id == "" ? 1 : 0
  account_id   = "signalfx-integration${var.suffix == "" ? "" : "-${lower(var.suffix)}"}"
  display_name = "SignalFX integration${var.suffix == "" ? "" : " - ${title(var.suffix)}"}"
}

locals {
  id_to_use = length(data.google_service_account.sfx_service_account) > 0 ? data.google_service_account.sfx_service_account[0].id : google_service_account.sfx_service_account[0].id
}

resource "google_service_account_key" "sak" {
  service_account_id = local.id_to_use
}

