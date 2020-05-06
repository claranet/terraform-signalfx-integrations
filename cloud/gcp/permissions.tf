resource "google_project_iam_custom_role" "sfx_role" {
  count = var.gcp_service_account_id == "" ? 1 : 0

  role_id     = "signalfx${var.suffix == "" ? "" : ".${substr(lower(replace(var.suffix, "-", "_")), 0, 64)}"}"
  title       = "SignalFx${var.suffix == "" ? "" : " - ${title(var.suffix)}"}"
  description = "SignalFx viewer role for monitoring${var.suffix == "" ? "" : " for ${lower(var.suffix)}"}"
  permissions = [
    "monitoring.metricDescriptors.get",
    "monitoring.metricDescriptors.list",
    "monitoring.timeSeries.list",
    "resourcemanager.projects.get",
    "compute.instances.list",
    "compute.machineTypes.list",
    "spanner.instances.list",
    "storage.buckets.list",
  ]
}

resource "google_project_iam_member" "sfx_service_account_membership" {
  count = var.gcp_service_account_id == "" ? 1 : 0

  project = var.gcp_project_id
  role    = "projects/${var.gcp_project_id}/roles/${google_project_iam_custom_role.sfx_role[0].role_id}"
  member  = "serviceAccount:${google_service_account.sfx_service_account[0].email}"
}
