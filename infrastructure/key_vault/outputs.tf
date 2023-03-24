output "keyvault_id" {
  value = azurerm_key_vault.genomics_etl_key_vault.id
}

output "illumina_dataset_sas_token" {
  value = azurerm_key_vault_secret.illumina_dataset_sas_token_keyvaut_secret.name
}
