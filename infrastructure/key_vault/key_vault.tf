resource "azurerm_key_vault" "genomics_etl_key_vault" {
  name                        = "${var.project}-kv-${var.environment}"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  enable_rbac_authorization   = true
  sku_name                    = "standard"

  access_policy {
    object_id = var.current_aad_user_id
    tenant_id = var.tenant_id

    key_permissions = [
      "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore",
      "Sign", "UnwrapKey", "Update", "Verify", "WrapKey"
    ]

    secret_permissions = [
      "Backup", "Delete", "Get", "List", "Recover", "Restore", "Set"
    ]

    certificate_permissions = [
      "Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers",
      "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"
    ]

  }

}


resource "random_password" "postgres_admin_password_value" {
  length  = 50
  special = false
}

resource "azurerm_key_vault_secret" "postgres_admin_password_keyvault_secret" {
  name         = "${var.project}-postgres-admin-password-${var.environment}"
  value        = random_password.postgres_admin_password_value.result
  key_vault_id = azurerm_key_vault.genomics_etl_key_vault.id
}


resource "random_password" "postgres_admin_username_value" {
  length  = 10
  special = false
}

resource "azurerm_key_vault_secret" "postgres_admin_username_keyvault_secret" {
  name         = "${var.project}-postgres-admin-username-${var.environment}"
  value        = random_password.postgres_admin_username_value.result
  key_vault_id = azurerm_key_vault.genomics_etl_key_vault.id
}

resource "azurerm_key_vault_secret" "postgres_admin_connectionstring_keyvault_secret" {
  name         = "${var.project}-postgres-admin-connection-string-${var.environment}"
  value        = var.postgres_admin_conection_string
  key_vault_id = azurerm_key_vault.genomics_etl_key_vault.id
}

resource "azurerm_key_vault_secret" "illumina_dataset_sas_token_keyvaut_secret" {
  name         = "${var.project}-illumina-dataset-sas-token-${var.environment}"
  value        = var.illumina_dataset_sas_token
  key_vault_id = azurerm_key_vault.genomics_etl_key_vault.id
}

resource "azurerm_key_vault_secret" "illumina_dataset_sas_uri_keyvaut_secret" {
  name         = "${var.project}-illumina-dataset-sas-uri-${var.environment}"
  value        = var.illumina_dataset_sas_uri
  key_vault_id = azurerm_key_vault.genomics_etl_key_vault.id
}

resource "azurerm_key_vault_secret" "adls_sas_token" {
  name         = "${var.project}-adls-sas-token-${var.environment}"
  value        = var.adls_sas_token
  key_vault_id = azurerm_key_vault.genomics_etl_key_vault.id
}








resource "azurerm_user_assigned_identity" "keyvault_managed_identity" {
  name                = "${var.project}-keyvault-managed-identity"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "keyvault_managed_identity_as_keyvault_admin" {
  scope                = azurerm_key_vault.genomics_etl_key_vault.id   # var.azurerm_key_vault_id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azurerm_user_assigned_identity.keyvault_managed_identity.principal_id
}

resource "azurerm_federated_identity_credential" "keyvault_managed_identity_credential" {
  name                = "keyvault_managed_identity_credential"
  resource_group_name = var.resource_group_name #azurerm_resource_group.example.name
  audience            = ["foo"]
  issuer              = "https://foo"
  parent_id           = azurerm_user_assigned_identity.keyvault_managed_identity.id
  subject             = "foo"
}
