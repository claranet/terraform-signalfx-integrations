# PagerDuty Integration specific

variable "enable_flag" {
	description = "Pagerduty enable flag"
	default = "true"
}

variable "api_key" {
	description = "Pagerduty API token"
	default = ""
}
