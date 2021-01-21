locals {
  application_name = "terraform-modules-development-approle"
}

resource "vault_namespace" "default" {
  path = local.application_name
}

provider "vault" {
  alias     = "default"
  namespace = trimsuffix(vault_namespace.default.id, "/")
}

resource "vault_auth_backend" "default" {
  provider = vault.default
  type     = "approle"
  tune {
    max_lease_ttl     = "8760h"
    default_lease_ttl = "8760h"
  }
}

module "default" {
  source = "./module"
  providers = {
    vault = vault.default
  }
  group_ids = [module.vault_approle.group_id]
}

module "vault_approle" {
  source = "git::https://github.com/devops-adeel/terraform-vault-approle.git?ref=v0.5.0"
  providers = {
    vault = vault.default
  }
  application_name = local.application_name
  env              = "dev"
  service          = "web"
  mount_accessor   = vault_auth_backend.default.accessor
}

resource "vault_approle_auth_backend_login" "default" {
  provider  = vault.default
  backend   = module.vault_approle.backend_path
  role_id   = module.vault_approle.approle_id
  secret_id = module.vault_approle.approle_secret
}

provider "vault" {
  alias = "integration"
  namespace = trimsuffix(vault_namespace.default.id, "/")
  token = vault_approle_auth_backend_login.default.client_token
}

data "vault_auth_backend" "test" {
  provider = vault.integration
  path = "token"
}

output "vault_path" {
  value = data.vault_auth_backend.test.type
}

output "testing" {
  value = "Testing"
}
