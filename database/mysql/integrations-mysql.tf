resource "random_password" "sfx" {
  count = var.create_monitoring_user ? 1 : 0

  length  = 32
  special = false
}

resource "mysql_user" "sfx" {
  count = var.create_monitoring_user ? 1 : 0

  provider = mysql.sfx-integration

  user               = var.monitoring_user_login
  host               = var.monitoring_user_host
  plaintext_password = join("", random_password.sfx.*.result)
}

resource "mysql_grant" "sfx_base" {
  provider = mysql.sfx-integration

  user       = var.monitoring_user_login
  host       = var.monitoring_user_host
  database   = "*"
  privileges = ["REPLICATION CLIENT", "PROCESS"]

  depends_on = [mysql_user.sfx]
}

resource "mysql_grant" "sfx_perf" {
  provider = mysql.sfx-integration

  user       = var.monitoring_user_login
  host       = var.monitoring_user_host
  database   = "performance_schema"
  privileges = ["SELECT"]

  depends_on = [mysql_user.sfx]
}
