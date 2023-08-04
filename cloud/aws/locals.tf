locals {
  integration_name  = "AWSIntegration${var.suffix == "" ? "" : "-${title(var.suffix)}"}"
  excluded_services = concat(var.excluded_services, ["AWS/EC2"])

  monitored_services = setsubtract(
    concat(var.included_services, var.extra_included_services),
    concat(var.excluded_services, ["AWS/EC2"]),
  )
}
