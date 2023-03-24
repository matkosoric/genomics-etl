output "adls_id" {
  value = azurerm_storage_account.genomics_etl_data.id
}

output "adls_connection_string" {
  value = azurerm_storage_account.genomics_etl_data.primary_connection_string
}

output "adls_sas_token" {
  value = data.azurerm_storage_account_sas.adls_sas_token.sas
}
