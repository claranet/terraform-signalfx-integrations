resource "azuread_application" "signalfx_integration" {
  display_name = local.integration_name
}

resource "azuread_service_principal" "signalfx_integration_sp" {
  application_id               = azuread_application.signalfx_integration.application_id
  app_role_assignment_required = false
}

resource "azuread_service_principal_password" "signalfx_integration_sp_pwd" {
  service_principal_id = azuread_service_principal.signalfx_integration_sp.id
  end_date_relative    = "${var.azure_spn_token_validity_duration_hours}h"
}

resource "azurerm_role_assignment" "signalfx_integration_sp_reader" {
  for_each = toset(var.azure_subscription_ids)

  scope                = format("/subscriptions/%s", each.key)
  role_definition_name = "Reader"
  principal_id         = azuread_service_principal.signalfx_integration_sp.object_id
}
