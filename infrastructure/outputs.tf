output "service_principal_id" {
  value = var.service_principal_id
}

output "postgres_admin_password" {
  value = nonsensitive(module.postgres.postgres_admin_password)
}

output "postgres_admin_conection_string" {
  value = nonsensitive(module.postgres.postgres_admin_conection_string)
}

output "server_name" {
  value = module.postgres.server_name
}