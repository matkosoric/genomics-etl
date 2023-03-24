output "postgres_admin_conection_string" {
  value = "Server=${azurerm_postgresql_server.genomics_etl_postgres.fqdn};Port=5432;Database=postgres;UID=${local.admin_complete_username};EncryptionMethod=1;Password=${random_password.postgres_admin_password_value.result};"
}

output "postgres_admin_password" {
  value = random_password.postgres_admin_password_value.result
}

locals {
  admin_complete_username = "${var.admin_username}@${azurerm_postgresql_server.genomics_etl_postgres.name}"
}

output "server_name" {
  value = azurerm_postgresql_server.genomics_etl_postgres.name
}




