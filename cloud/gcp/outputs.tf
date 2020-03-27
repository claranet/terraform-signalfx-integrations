output "gcp_service_account_id" {
  description = "The GCP service account id used by SignalFx"
  value       = google_service_account.sfx_service_account.*.id
}
