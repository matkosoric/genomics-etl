output "adls_id" {
  value = azurerm_storage_account.genomics_etl_data.id
}

output "adls_connection_string" {
  value = azurerm_storage_account.genomics_etl_data.primary_connection_string
}

output "adls_sas_token" {
  value = data.azurerm_storage_account_sas.adls_sas_token.sas
}

output "container_name_landing_raw_data" {
  value = azurerm_storage_container.genomics_etl_data_landing.name
}

output "storage_account_name" {
  value = azurerm_storage_account.genomics_etl_data.name
}

output "landing_container_sas_token" {
  value = data.azurerm_storage_account_blob_container_sas.landing_container_sas_token.sas
}


