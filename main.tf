data "vault_policy_document" "default" {
  rule {
    path         = "sys/policies/acl/*"
    capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    description  = "Create and manage ACL policies"
  }
  rule {
    path         = "auth/*"
    capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    description  = "Manage auth methods broadly across Vault Namespace"
  }
  rule {
    path         = "sys/auth/*"
    capabilities = ["read"]
    description  = "List auth methods"
  }
  rule {
    path         = "auth/token/create"
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
