data "azurerm_client_config" "current" {}

module "adf" {
  source                          = "./adf"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  adls_id                         = module.adls.adls_id
  project                         = local.project
  environment                     = local.environment
  postgres_admin_conection_string = module.postgres.postgres_admin_conection_string
  adls_connection_string          = module.adls.adls_connection_string
  azurerm_key_vault_id            = module.key_vault.keyvault_id
  subscription_id                 = var.subscription_id
}

module "postgres" {
  source              = "./postgres"
  location            = var.location
  resource_group_name = var.resource_group_name
  admin_username      = local.postgres_admin_username
  project             = local.project
  environment         = local.environment
}

module "adls" {
  source                                = "./adls"
  resource_group_name                   = var.resource_group_name
  location                              = var.location
  project                               = local.project
  environment                           = local.environment
  adf_user_assigned_managed_identity_id = module.adf.adf_user_assigned_managed_identity_id
}

module "key_vault" {
  source                          = "./key_vault"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  tenant_id                       = var.tenant_id
  project                         = local.project
  environment                     = local.environment
  current_aad_user_id             = var.current_aad_user_id
  postgres_admin_conection_string = module.postgres.postgres_admin_conection_string
  illumina_dataset_sas_token      = var.illumina_dataset_sas_token
  adls_sas_token                  = module.adls.adls_sas_token
  illumina_dataset_sas_uri        = var.illumina_dataset_sas_uri
}


#module "databricks" {
#  source         = "./databricks"
#  region         = var.region
#  resource_group = var.resource_group_name
#
#  client_id                       = var.service_principal_id
#  client_secret                   = var.client_secret
#  tenant_id                       = var.tenant_id
#  subscription_id                 = var.subscription_id
#  prefix                          = local.project
#  tags                            = local.tags
#  databricks_admin_mail           = var.databricks_admin_mail
#  current_aad_user_id             = var.current_aad_user_id
#  container_name_landing_raw_data = module.adls.container_name_landing_raw_data
#  storage_account_name            = module.adls.storage_account_name
#  landing_container_sas_token     = module.adls.landing_container_sas_token
#  postgres_fqdn                   = module.postgres.postgres_fqdn
#  admin_username                  = module.postgres.admin_username
#  postgres_admin_password         = module.postgres.postgres_admin_password
#  environment                     = var.environment
#}



