## Requirements

No requirements.

## Providers

| Name    | Version   |
| ------  | --------- |
| `vault` | n/a       |

## Modules

No Modules.

## Resources

| Name                                                                                                                                   |
| ------                                                                                                                                 |
| [vault_identity_entity](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/identity_entity)              |
| [vault_identity_entity](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_entity)                 |
| [vault_identity_group](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_group)                   |
| [vault_identity_group_policies](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_group_policies) |
| [vault_policy](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy)                                   |
| [vault_policy_document](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/policy_document)              |

## Inputs

| Name        | Description                              | Type           | Default   | Required   |
| ------      | -------------                            | ------         | --------- | :--------: |
| `group_ids` | List of Vault Identity Entity Member IDs | `list(string)` | `[]`      | no         |

## Outputs

| Name                | Description                                                 |
| ------              | -------------                                               |
| `vault_policy_name` | The Vault Policy name to be provided to authroles or entity |
