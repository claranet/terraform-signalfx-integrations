locals {
  id_to_use        = var.gcp_service_account_id == "" ? google_service_account.sfx_service_account[0].id : var.gcp_service_account_id
  integration_name = "GCPIntegration${var.suffix == "" ? "" : "-${title(var.suffix)}"}"
}

