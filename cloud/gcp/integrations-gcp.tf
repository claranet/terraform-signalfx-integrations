resource "signalfx_gcp_integration" "gcp_claranet_integration" {
  name      = "GCPIntegration${var.suffix == "" ? "" : "-${title(var.suffix)}"}"
  enabled   = var.enabled
  poll_rate = var.poll_rate
  project_service_keys {
    project_id  = var.gcp_project_id
    project_key = base64decode(google_service_account_key.sak.private_key)
  }

  services = var.services

  depends_on = [google_project_iam_member.sfx_service_account_membership]
}
