locals {
  admin_complete_username = "${var.admin_username}@${azurerm_postgresql_server.genomics_etl_postgres.name}"
}