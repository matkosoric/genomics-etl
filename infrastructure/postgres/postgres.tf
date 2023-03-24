resource "azurerm_postgresql_server" "genomics_etl_postgres" {
  name                = "${var.project}-psqlserver-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login          = var.admin_username
  administrator_login_password = random_password.postgres_admin_password_value.result

  sku_name   = "GP_Gen5_2"
  version    = "11"
  storage_mb = 640000

  backup_retention_days        = 7
  geo_redundant_backup_enabled = true
  auto_grow_enabled            = true

  public_network_access_enabled    = true
  ssl_enforcement_enabled          = false
  ssl_minimal_tls_version_enforced = "TLSEnforcementDisabled"
}

resource "random_password" "postgres_admin_password_value" {
  length  = 50
  special = false
}


resource "azurerm_postgresql_firewall_rule" "allow_azure_services" {
  name                = "allow-access-to-azure-services"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.genomics_etl_postgres.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}