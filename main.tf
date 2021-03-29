/**
 * Usage:
 *
 * ```hcl
 *
 * module "vault_admin_policy" {
 *   source = "git::https://github.com/devops-adeel/terraform-vault-policy-ns-admin.git?ref=v0.5.0"
 *   entity_ids = [module.vault_approle.entity_id]
 * }
 * ```
 */


locals {
  member_entity_ids = var.entity_ids != [] ? var.entity_ids : [vault_identity_entity.default.id]
}

data "vault_policy_document" "default" {
  rule {
    path         = "sys/policies/acl/*"
    capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    description  = "Create and manage ACL policies"
  }
  rule {
    path         = "sys/capabilities-self"
    capabilities = ["read", "list"]
    description  = "Endpoint returns capabilities of client token on given path"
  }
  rule {
    path         = "auth/*"
    capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    description  = "Manage auth methods broadly across Vault Namespace"
  }
  rule {
    path         = "sys/auth/*"
    capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    description  = "Manage auth methods broadly across Vault Namespace"
  }
  rule {
    path         = "sys/auth"
    capabilities = ["read"]
    description  = "List auth methods"
  }
  rule {
    path         = "auth/token/*"
    capabilities = ["create", "read", "update", "delete", "list"]
    description  = "create child tokens"
  }
  rule {
    path         = "secret/*"
    capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    description  = "List, create, update, and delete key/value secrets"
  }
  rule {
    path         = "transit/*"
    capabilities = ["create", "read", "update", "delete", "list"]
    description  = "Manage the transit secrets engine"
  }
  rule {
    path         = "identity/*"
    capabilities = ["create", "read", "update", "delete", "list"]
    description  = "Manage the transit secrets engine"
  }
  rule {
    path         = "azure/*"
    capabilities = ["create", "read", "update", "delete", "list"]
    description  = "Manage the azure secrets engine"
  }
  rule {
    path         = "aws/*"
    capabilities = ["create", "read", "update", "delete", "list"]
    description  = "Manage the aws secrets engine"
  }
  rule {
    path         = "gcp/*"
    capabilities = ["create", "read", "update", "delete", "list"]
    description  = "Manage the gcp secrets engine"
  }
  rule {
    path         = "terraform/*"
    capabilities = ["create", "read", "update", "delete", "list"]
    description  = "Manage the tfc secrets engine"
  }
  rule {
    path         = "sys/mounts/*"
    capabilities = ["create", "read", "update", "delete", "list"]
    description  = "List existing & create new secrets engines."
  }
  rule {
    path         = "sys/mounts"
    capabilities = ["read"]
    description  = "List existing secrets engines."
  }
}

resource "vault_policy" "default" {
  name   = "admin"
  policy = data.vault_policy_document.default.hcl
}

resource "vault_identity_group" "default" {
  name              = "admin"
  type              = "internal"
  external_policies = true
  member_entity_ids = local.member_entity_ids
}

resource "vault_identity_group_policies" "default" {
  exclusive = false
  group_id  = vault_identity_group.default.id
  policies = [
    "default",
    vault_policy.default.name,
  ]
}

data "vault_identity_entity" "default" {
  entity_id = vault_identity_entity.default.id
}

resource "vault_identity_entity" "default" {
  name = "admin"
  metadata = {
    env     = "dev"
    service = "example"
  }
}
