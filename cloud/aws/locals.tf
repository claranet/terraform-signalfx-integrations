locals {
  integration_name = "AWSIntegration${var.suffix == "" ? "" : "-${title(var.suffix)}"}"
  open_aws_services = [
    for service in data.signalfx_aws_services.aws_services.services[*].name :
    service if !contains(concat(["AWS/EC2"], var.excluded_services), service)
  ]
}

