variable "project" {
  default = "genomics-etl-2"
}

variable "region" {
  type    = string
  default = "westus3"
}

variable "resource_group_name" {
  type    = string
  default = "ALLGDP"
}

variable "location" {
  type    = string
  default = "West US 2"
}

variable "environment" {
  default = "dev"
}


variable "service_principal_object_id" {
  type = string
}

variable "service_principal_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "current_aad_user_id" {
  type = string
}

variable "github_token" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "illumina_dataset_sas_token" {
  type = string
}

variable "illumina_dataset_sas_uri" {
  type = string
}

variable "databricks_admin_mail" {
  type = string
}

