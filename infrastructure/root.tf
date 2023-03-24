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

  backend "azurerm" {
    resource_group_name  = "ALLGDP"
    storage_account_name = "genomicsetl"
    container_name       = "genomics-etl-2-terraform-state"
    key                  = "terraform.tfstate"
  }

}

provider "azurerm" {
  features {}
  skip_provider_registration = "true"
}


