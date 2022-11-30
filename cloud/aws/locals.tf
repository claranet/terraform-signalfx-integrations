locals {
  integration_name  = "AWSIntegration${var.suffix == "" ? "" : "-${title(var.suffix)}"}"
  all_services      = data.signalfx_aws_services.aws_services.services[*].name
  excluded_services = concat(var.excluded_services, ["AWS/EC2"])
  aws_services      = coalescelist(tolist(setintersection(var.included_services, local.all_services)), local.all_services)
}
