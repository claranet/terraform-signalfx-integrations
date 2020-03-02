resource "google_project_iam_custom_role" "sfx_role" {
  role_id     = "signalfx${var.suffix == "" ? "" : ".${lower(var.suffix)}"}"
  title       = "SignalFX${var.suffix == "" ? "" : " - ${title(var.suffix)}"}"
  description = "SignalFX viewer role for monitoring${var.suffix == "" ? "" : " for ${lower(var.suffix)}"}"
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
  project = var.gcp_project_id
  role    = "projects/${var.gcp_project_id}/roles/${google_project_iam_custom_role.sfx_role.role_id}"
  member  = "serviceAccount:${google_service_account.sfx_service_account[0].email}"
}

