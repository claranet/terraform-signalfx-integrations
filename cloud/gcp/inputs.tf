# GCP Integration specific

variable "gcp_project_id" {
	description = "GCP project id for use with the GCP integration"
	type = string
	default = "gcp_project_id_1"
}

variable "gcp_project_key" {
	description = "GCP project key for use with GCP integration"
	default = ["${file("/path/to/gcp_credentials_1.json")}"]
}
