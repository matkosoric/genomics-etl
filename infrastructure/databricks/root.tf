terraform {

  required_version = "=1.3.9"

  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.45.0"
    }

    databricks = {
      source  = "databricks/databricks"
      version = "1.13.0"
    }

  }

}