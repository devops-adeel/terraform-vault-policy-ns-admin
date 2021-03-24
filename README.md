![inspec-test](https://github.com/devops-adeel/terraform-vault-policy-ns-admin/actions/workflows/terraform-apply.yml/badge.svg)

# Terraform Vault Admin Policy

This terraform module creates an admin policy with an ACL templated policy. This
is designed to run once in a given Vault namespace.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
Usage:

```hcl

module "vault_admin_policy" {
  source = "git::https://github.com/devops-adeel/terraform-vault-policy-ns-admin.git?ref=v0.5.0"
  entity_ids = [module.vault_approle.entity_id]
}
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vault"></a> [vault](#provider\_vault) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vault_identity_entity.default](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_entity) | resource |
| [vault_identity_group.default](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_group) | resource |
| [vault_identity_group_policies.default](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_group_policies) | resource |
| [vault_policy.default](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_identity_entity.default](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/identity_entity) | data source |
| [vault_policy_document.default](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_entity_ids"></a> [entity\_ids](#input\_entity\_ids) | List of Vault Identity Member IDs | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vault_policy_name"></a> [vault\_policy\_name](#output\_vault\_policy\_name) | The Vault Policy name to be provided to authroles or entity |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
