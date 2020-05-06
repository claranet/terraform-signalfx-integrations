resource "google_service_account" "sfx_service_account" {
  count        = var.gcp_service_account_id == "" ? 1 : 0
  account_id   = "signalfx${var.suffix == "" ? "" : "-${substr(lower(var.suffix), 0, 30)}"}"
  display_name = "SignalFx Integration${var.suffix == "" ? "" : " - ${title(var.suffix)}"}"
}

locals {
  id_to_use = var.gcp_service_account_id == "" ? google_service_account.sfx_service_account[0].id : var.gcp_service_account_id
}

resource "google_service_account_key" "sak" {
  service_account_id = local.id_to_use
}
