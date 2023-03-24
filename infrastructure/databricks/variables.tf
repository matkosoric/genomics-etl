variable "region" {
  type = string
}

variable "resource_group" {
  type = string
}

variable "prefix" {
  type = string
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "databricks_admin_mail" {
  type = string
}

variable "current_aad_user_id" {
  type = string
}

variable "container_name_landing_raw_data" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "landing_container_sas_token" {
  type = string
}

