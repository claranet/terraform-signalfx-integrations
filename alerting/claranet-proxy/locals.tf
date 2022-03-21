locals {
  integration_name = "ProxyAlerting${var.suffix == "" ? "" : "-${title(var.suffix)}"}"
  base64header = base64encode("${var.username}:${var.password}")
}

