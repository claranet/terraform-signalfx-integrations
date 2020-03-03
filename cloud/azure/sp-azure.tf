resource "azuread_application" "signalfx_integration" {
  name     = coalesce(var.custom_sfx_integration_name, local.default_integration_name)
  homepage = "https://www.signalfx.com/"

  available_to_other_tenants = false
  oauth2_allow_implicit_flow = false
}

resource "azuread_service_principal" "signalfx_integration_sp" {
  application_id               = azuread_application.signalfx_integration.application_id
  app_role_assignment_required = false
}

resource "random_password" "signalfx_integration_password" {
  length  = 32
  special = true
}

resource "azuread_service_principal_password" "signalfx_integration_sp_pwd" {
  service_principal_id = azuread_service_principal.signalfx_integration_sp.id
  value                = random_password.signalfx_integration_password.result
  end_date_relative    = var.azure_sp_validation_time
}

resource "azurerm_role_assignment" "signalfx_integration_sp_reader" {
  for_each = toset(var.azure_subscription_ids)

  scope                = format("/subscriptions/%s", each.key)
  role_definition_name = "Reader"
  principal_id         = azuread_service_principal.signalfx_integration_sp.object_id
}
