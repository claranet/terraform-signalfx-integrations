resource "signalfx_gcp_integration" "gcp_claranet" {
	name = "GCP - Claranet"
	enabled = true
	poll_rate = 300
	project_service_keys {
		project_id = var.gcp_project_id
		project_key = var.gcp_project_key
	}
}
