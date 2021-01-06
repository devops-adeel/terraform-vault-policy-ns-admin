output "vault_policy_name" {
  description = "The Vault Policy name to be provided to authroles or entity"
  value       = vault_policy.default.name
}
