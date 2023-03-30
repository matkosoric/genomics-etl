provider "azurerm" {
  features {}
}

resource "azurerm_storage_account" "genomics_etl_data" {
  name                     = "genomicsetl${var.environment}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
  routing {
    publish_microsoft_endpoints = true
  }

  identity {
    type         = "UserAssigned" # SystemAssigned,
    identity_ids = [var.adf_user_assigned_managed_identity_id]
  }
}

resource "azurerm_storage_container" "genomics_etl_data_landing" {
  name                  = "1-landing-raw-data"
  storage_account_name  = azurerm_storage_account.genomics_etl_data.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "genomics_etl_parquet" {
  name                  = "2-parquet"
  storage_account_name  = azurerm_storage_account.genomics_etl_data.name
  container_access_type = "private"
}

data "azurerm_storage_account_sas" "adls_sas_token" {
  connection_string = azurerm_storage_account.genomics_etl_data.primary_connection_string
  https_only        = true
  signed_version    = "2017-07-29"

  resource_types {
    service   = true
    container = false
    object    = false
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  start  = "2023-03-10T00:00:00Z"
  expiry = "2023-03-31T00:00:00Z"

  permissions {
    read    = true
    write   = true
    delete  = true
    list    = true
    add     = true
    create  = true
    update  = true
    process = true
    tag     = true
    filter  = true
  }
}




data "azurerm_storage_account_blob_container_sas" "landing_container_sas_token" {
  connection_string = azurerm_storage_account.genomics_etl_data.primary_connection_string
  container_name    = azurerm_storage_container.genomics_etl_data_landing.name
  https_only        = true

  start  = "2023-03-01"
  expiry = "2023-04-01"

  permissions {
    read   = true
    add    = true
    create = true
    write  = true
    delete = true
    list   = true
  }

  cache_control       = "max-age=5"
  content_disposition = "inline"
  content_encoding    = "deflate"
  content_language    = "en-US"
  content_type        = "application/json"
}

