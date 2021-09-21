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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.26 |
| <a name="requirement_signalfx"></a> [signalfx](#requirement\_signalfx) | >= 4.26.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_mysql.sfx-integration"></a> [mysql.sfx-integration](#provider\_mysql.sfx-integration) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [mysql_grant.sfx_base](https://registry.terraform.io/providers/hashicorp/mysql/latest/docs/resources/grant) | resource |
| [mysql_grant.sfx_perf](https://registry.terraform.io/providers/hashicorp/mysql/latest/docs/resources/grant) | resource |
| [mysql_user.sfx](https://registry.terraform.io/providers/hashicorp/mysql/latest/docs/resources/user) | resource |
| [random_password.sfx](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connection_use_tls"></a> [connection\_use\_tls](#input\_connection\_use\_tls) | Set if TLS should be used for db connection. One of `false`, `true`, or `skip-verify`. See https://www.terraform.io/docs/providers/mysql/index.html#tls | `string` | `"false"` | no |
| <a name="input_create_monitoring_user"></a> [create\_monitoring\_user](#input\_create\_monitoring\_user) | `true` if the user used for monitoring should be created | `bool` | `true` | no |
| <a name="input_monitoring_user_host"></a> [monitoring\_user\_host](#input\_monitoring\_user\_host) | MySQL user host for monitoring | `string` | `"%"` | no |
| <a name="input_monitoring_user_login"></a> [monitoring\_user\_login](#input\_monitoring\_user\_login) | MySQL user login for monitoring | `string` | `"sfx"` | no |
| <a name="input_mysql_server_admin_login"></a> [mysql\_server\_admin\_login](#input\_mysql\_server\_admin\_login) | MySQL server administrator login | `string` | n/a | yes |
| <a name="input_mysql_server_admin_password"></a> [mysql\_server\_admin\_password](#input\_mysql\_server\_admin\_password) | MySQL server administrator password | `string` | n/a | yes |
| <a name="input_mysql_server_host"></a> [mysql\_server\_host](#input\_mysql\_server\_host) | MySQL server host to connect to | `string` | n/a | yes |
| <a name="input_mysql_server_port"></a> [mysql\_server\_port](#input\_mysql\_server\_port) | MySQL server port | `number` | `"3306"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_monitoring_user_host"></a> [monitoring\_user\_host](#output\_monitoring\_user\_host) | Monitoring user password |
| <a name="output_monitoring_user_login"></a> [monitoring\_user\_login](#output\_monitoring\_user\_login) | Monitoring user login |
| <a name="output_monitoring_user_password"></a> [monitoring\_user\_password](#output\_monitoring\_user\_password) | Monitoring user password if created by the module |
<!-- END_TF_DOCS -->

## Related documentation

[Official documentation](https://docs.signalfx.com/en/latest/integrations/integrations-reference/integrations.mysql.html)
[Collectd documentation](https://collectd.org/wiki/index.php/Plugin:MySQL)

## Purpose

This module prepares a MySQL server for use with SignalFx.
