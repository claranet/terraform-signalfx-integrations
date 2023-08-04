locals {
  integration_name  = "AWSIntegration${var.suffix == "" ? "" : "-${title(var.suffix)}"}"
  excluded_services = concat(var.excluded_services, ["AWS/EC2"])
  aws_services      = var.included_services
}
