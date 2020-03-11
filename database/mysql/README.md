# DATABASE MYSQL SignalFx integrations

## How to use this module

```
module "signalfx-integrations-database-mysql" {
  source = "git::ssh://git@github.com/claranet/terraform-signalfx-integrations.git//database/mysql?ref={revision}"

  mysql_server_host           = var.mysql_host
  mysql_server_admin_login    = var.mysql_admin_login
  mysql_server_admin_password = var.mysql_admin_password
}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| connection\_use\_tls | Set if TLS should be used for db connection. One of `false`, `true`, or `skip-verify`. See https://www.terraform.io/docs/providers/mysql/index.html#tls | `string` | `"false"` | no |
| create\_monitoring\_user | `true` if the user used for monitoring should be created | `bool` | `true` | no |
| monitoring\_user\_host | MySQL user host for monitoring | `string` | `"%"` | no |
| monitoring\_user\_login | MySQL user login for monitoring | `string` | `"sfx"` | no |
| mysql\_server\_admin\_login | MySQL server administrator login | `string` | n/a | yes |
| mysql\_server\_admin\_password | MySQL server administrator password | `string` | n/a | yes |
| mysql\_server\_host | MySQL server host to connect to | `string` | n/a | yes |
| mysql\_server\_port | MySQL server port | `number` | `"3306"` | no |

## Outputs

| Name | Description |
|------|-------------|
| monitoring\_user\_host | Monitoring user password |
| monitoring\_user\_login | Monitoring user login |
| monitoring\_user\_password | Monitoring user password if created by the module |

## Related documentation

[Official documentation](https://docs.signalfx.com/en/latest/integrations/integrations-reference/integrations.mysql.html)
[Collectd documentation](https://collectd.org/wiki/index.php/Plugin:MySQL)

## Purpose

This module prepares a MySQL server for use with SignalFx.
