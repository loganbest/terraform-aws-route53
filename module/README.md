<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.8 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_endpoints"></a> [endpoints](#module\_endpoints) | ./endpoints | n/a |
| <a name="module_resolver_rules"></a> [resolver\_rules](#module\_resolver\_rules) | ./resolver_rules | n/a |
| <a name="module_zones"></a> [zones](#module\_zones) | ./zones | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_overwrite"></a> [allow\_overwrite](#input\_allow\_overwrite) | (Optional) Default allow\_overwrite value valid for all record sets. | `bool` | `false` | no |
| <a name="input_create_phz"></a> [create\_phz](#input\_create\_phz) | (Optional) Defines whether to create the PHZ or not. Useful in consul env's where resolver rule is preferred. (Default: False) | `bool` | `false` | no |
| <a name="input_default_ttl"></a> [default\_ttl](#input\_default\_ttl) | (Optional) The default TTL ( Time to Live ) in seconds that will be used for all records that support the ttl parameter. Will be overwritten by the records ttl parameter if set. | `number` | `3600` | no |
| <a name="input_enable_resolver_inbound_endpoint"></a> [enable\_resolver\_inbound\_endpoint](#input\_enable\_resolver\_inbound\_endpoint) | Whether to include an Inbound Endpoint in the VPC | `bool` | `false` | no |
| <a name="input_enable_resolver_outbound_endpoint"></a> [enable\_resolver\_outbound\_endpoint](#input\_enable\_resolver\_outbound\_endpoint) | Whether to include an Outbound Endpoint in the VPC | `bool` | `false` | no |
| <a name="input_enable_resolver_rules"></a> [enable\_resolver\_rules](#input\_enable\_resolver\_rules) | Whether to include Resolver Rules in the VPC | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | (Optional) Whether to force destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone. | `bool` | `false` | no |
| <a name="input_forward_rules"></a> [forward\_rules](#input\_forward\_rules) | A complex object of map(object()) defining a Forward Rule and their share status.<br>    'shared' defines if these resolver rules are shared with the entire Gemini AWS Org. Only valid inside Network Services Account (Default: False)<br>    'domain\_name' is the domain of the remote PHZ<br>    'name' is a friendly name for the PHZ, generally the VPC name is fine<br>    'rule\_type' is almost always going to be FORWARD and will default to it<br>    'target\_ips' is a list of IPs where the dns query will be forwarded to. Optionally you can use ['inbound'] to dynamically use the R53 Inbound Endpoint IPs. Really wish tf supported optional params inside objects... | <pre>object({<br>    shared = bool<br>    inbound = map(object({<br>      domain_name = string<br>      name        = string<br>      rule_type   = string<br>      target_ips  = list(string)<br>    }))<br>    outbound = map(object({<br>      domain_name = string<br>      name        = string<br>      rule_type   = string<br>      target_ips  = list(string)<br>    }))<br>  })</pre> | <pre>{<br>  "inbound": {},<br>  "outbound": {},<br>  "shared": false<br>}</pre> | no |
| <a name="input_is_netsvc_account"></a> [is\_netsvc\_account](#input\_is\_netsvc\_account) | Boolean to define whether this is in Network Services account or not (Default: False) | `bool` | `false` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_records"></a> [records](#input\_records) | (Optional) A list of records to create in the Hosted Zone. | `any` | `[]` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | (Optional) Private Subnet IDs for Resolver Endpoints | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
| <a name="input_terragrunt_tags"></a> [terragrunt\_tags](#input\_terragrunt\_tags) | tags added by terragrunt automatically | `map(string)` | `{}` | no |
| <a name="input_vpc_ids"></a> [vpc\_ids](#input\_vpc\_ids) | (Optional) A list of IDs of VPCs to associate with a private hosted zone. Conflicts with the delegation\_set\_id. | `list(string)` | `[]` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | vpc\_name (supplied by terragrunt) | `string` | `null` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | (Optional) A zone ID to create the records in | `string` | `null` | no |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | (Required) The name of the hosted zone(s). To create multiple zones at once, pass a list of names ["zone1", "zone2"]. | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoints"></a> [endpoints](#output\_endpoints) | n/a |
| <a name="output_resolver_rules"></a> [resolver\_rules](#output\_resolver\_rules) | n/a |
| <a name="output_zones"></a> [zones](#output\_zones) | n/a |
<!-- END_TF_DOCS -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.8 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_endpoints"></a> [endpoints](#module\_endpoints) | ./endpoints | n/a |
| <a name="module_resolver_rules"></a> [resolver\_rules](#module\_resolver\_rules) | ./resolver_rules | n/a |
| <a name="module_zones"></a> [zones](#module\_zones) | ./zones | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_overwrite"></a> [allow\_overwrite](#input\_allow\_overwrite) | (Optional) Default allow\_overwrite value valid for all record sets. | `bool` | `false` | no |
| <a name="input_create_phz"></a> [create\_phz](#input\_create\_phz) | (Optional) Defines whether to create the PHZ or not. Useful in consul env's where resolver rule is preferred. (Default: False) | `bool` | `false` | no |
| <a name="input_default_ttl"></a> [default\_ttl](#input\_default\_ttl) | (Optional) The default TTL ( Time to Live ) in seconds that will be used for all records that support the ttl parameter. Will be overwritten by the records ttl parameter if set. | `number` | `3600` | no |
| <a name="input_enable_resolver_inbound_endpoint"></a> [enable\_resolver\_inbound\_endpoint](#input\_enable\_resolver\_inbound\_endpoint) | Whether to include an Inbound Endpoint in the VPC | `bool` | `false` | no |
| <a name="input_enable_resolver_outbound_endpoint"></a> [enable\_resolver\_outbound\_endpoint](#input\_enable\_resolver\_outbound\_endpoint) | Whether to include an Outbound Endpoint in the VPC | `bool` | `false` | no |
| <a name="input_enable_resolver_rules"></a> [enable\_resolver\_rules](#input\_enable\_resolver\_rules) | Whether to include Resolver Rules in the VPC | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | (Optional) Whether to force destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone. | `bool` | `false` | no |
| <a name="input_forward_rules"></a> [forward\_rules](#input\_forward\_rules) | A complex object of map(object()) defining a Forward Rule and their share status.<br>    'shared' defines if these resolver rules are shared with the entire Gemini AWS Org. Only valid inside Network Services Account (Default: False)<br>    'domain\_name' is the domain of the remote PHZ<br>    'name' is a friendly name for the PHZ, generally the VPC name is fine<br>    'rule\_type' is almost always going to be FORWARD and will default to it<br>    'target\_ips' is a list of IPs where the dns query will be forwarded to. Optionally you can use ['inbound'] to dynamically use the R53 Inbound Endpoint IPs. Really wish tf supported optional params inside objects... | <pre>object({<br>    shared = bool<br>    inbound = map(object({<br>      domain_name = string<br>      name        = string<br>      rule_type   = string<br>      target_ips  = list(string)<br>    }))<br>    outbound = map(object({<br>      domain_name = string<br>      name        = string<br>      rule_type   = string<br>      target_ips  = list(string)<br>    }))<br>  })</pre> | <pre>{<br>  "inbound": {},<br>  "outbound": {},<br>  "shared": false<br>}</pre> | no |
| <a name="input_is_netsvc_account"></a> [is\_netsvc\_account](#input\_is\_netsvc\_account) | Boolean to define whether this is in Network Services account or not (Default: False) | `bool` | `false` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_records"></a> [records](#input\_records) | (Optional) A list of records to create in the Hosted Zone. | `any` | `[]` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | (Optional) Private Subnet IDs for Resolver Endpoints | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
| <a name="input_terragrunt_tags"></a> [terragrunt\_tags](#input\_terragrunt\_tags) | tags added by terragrunt automatically | `map(string)` | `{}` | no |
| <a name="input_vpc_ids"></a> [vpc\_ids](#input\_vpc\_ids) | (Optional) A list of IDs of VPCs to associate with a private hosted zone. Conflicts with the delegation\_set\_id. | `list(string)` | `[]` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | vpc\_name (supplied by terragrunt) | `string` | `null` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | (Optional) A zone ID to create the records in | `string` | `null` | no |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | (Required) The name of the hosted zone(s). To create multiple zones at once, pass a list of names ["zone1", "zone2"]. | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoints"></a> [endpoints](#output\_endpoints) | n/a |
| <a name="output_resolver_rules"></a> [resolver\_rules](#output\_resolver\_rules) | n/a |
| <a name="output_zones"></a> [zones](#output\_zones) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
