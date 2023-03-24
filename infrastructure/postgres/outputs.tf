output "postgres_admin_conection_string" {
  value = "Server=${azurerm_postgresql_server.genomics_etl_postgres.fqdn};Port=5432;Database=postgres;UID=${local.admin_complete_username};EncryptionMethod=1;Password=${random_password.postgres_admin_password_value.result};"
}

output "postgres_admin_password" {
  value = random_password.postgres_admin_password_value.result
}

output "admin_username" {
  value = local.admin_complete_username
}

output "server_name" {
  value = azurerm_postgresql_server.genomics_etl_postgres.name
}

output "postgres_fqdn" {
  value = azurerm_postgresql_server.genomics_etl_postgres.fqdn
}


