output "token" {
  description = "Vault Client Token taken from approle"
  value       = vault_approle_auth_backend_login.default.client_token
}

output "url" {
  description = "Vault address where this module is tested against"
  value       = var.vault_address
}

output "namespace" {
  description = "Vault Namespace where integration tests will take place"
  value       = vault_namespace.default.id
}

output "path" {
  description = "Endpoint to test against."
  value       = "identity/entity/id?list=true"
}
