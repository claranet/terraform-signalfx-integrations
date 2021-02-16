locals {
  base64header = base64encode("${var.username}:${var.password}")
}

