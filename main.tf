locals {
  member_group_ids = var.group_ids != [] ? var.group_ids : [vault_identity_group.placeholder.id]
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
    description  = "This endpoint returns the capabilities of client token on the given paths."
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
    description  = "Manage the aws secrets engine"
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
  name   = "namespace-admin"
  policy = data.vault_policy_document.default.hcl
}

resource "vault_identity_group" "default" {
  name              = "namespace-admin"
  type              = "internal"
  external_policies = true
  member_group_ids  = local.member_group_ids
}

resource "vault_identity_group_policies" "default" {
  exclusive = false
  group_id  = vault_identity_group.default.id
  policies = [
    vault_policy.default.name,
  ]
}

resource "vault_identity_group" "placeholder" {
  name = "default"
}
