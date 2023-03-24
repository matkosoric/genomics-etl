resource "azurerm_data_factory" "genomics_etl_adf" {
  name                            = "${var.project}-adf-${var.environment}"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  managed_virtual_network_enabled = true

  identity {
    type         = "SystemAssigned, UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.adf_managed_identity.id]
  }

}






resource "azurerm_data_factory_managed_private_endpoint" "adls_managed_private_endpoint" {
  name               = "adls_managed_private_endpoint"
  data_factory_id    = azurerm_data_factory.genomics_etl_adf.id
  target_resource_id = var.adls_id
  subresource_name   = "blob"
}


resource "azurerm_user_assigned_identity" "adf_managed_identity" {
  location            = var.location
  name                = "${var.project}-adf-managed-identity"
  resource_group_name = var.resource_group_name
}


resource "azurerm_role_assignment" "adf_managed_identity_as_keyvault_admin" {
  scope                = var.azurerm_key_vault_id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azurerm_user_assigned_identity.adf_managed_identity.principal_id
}


resource "azurerm_role_assignment" "adf_managed_identity_as_adls_owner" {
  scope                = var.adls_id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = azurerm_user_assigned_identity.adf_managed_identity.principal_id
}




