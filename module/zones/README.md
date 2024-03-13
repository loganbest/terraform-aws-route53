# zones

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.40.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_route53_hosted_zone_dnssec.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_hosted_zone_dnssec) | resource |
| [aws_route53_key_signing_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_key_signing_key) | resource |
| [aws_route53_record.record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.phz](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_overwrite"></a> [allow\_overwrite](#input\_allow\_overwrite) | (Optional) Default allow\_overwrite value valid for all record sets. | `bool` | `false` | no |
| <a name="input_create_phz"></a> [create\_phz](#input\_create\_phz) | (Optional) Defines whether to create the PHZ or not. Useful in consul env's where resolver rule is preferred. (Default: False) | `bool` | `false` | no |
| <a name="input_default_ttl"></a> [default\_ttl](#input\_default\_ttl) | (Optional) The default TTL ( Time to Live ) in seconds that will be used for all records that support the ttl parameter. Will be overwritten by the records ttl parameter if set. | `number` | `3600` | no |
| <a name="input_enable_dnssec"></a> [enable\_dnssec](#input\_enable\_dnssec) | (Optional) Defines whether to create the DNSSEC keys or not for public hosted zones. (Default: True) | `bool` | `true` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | (Optional) Whether to force destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone. | `bool` | `false` | no |
| <a name="input_records"></a> [records](#input\_records) | (Optional) A list of records to create in the Hosted Zone. | <pre>list(object({<br>    name            = string<br>    type            = string<br>    ttl             = optional(number)       # required for non-alias records<br>    records         = optional(list(string)) # required for non-alias records<br>    zone_id         = optional(string)<br>    set_identifier  = optional(string)<br>    health_check_id = optional(string)<br><br>    alias = optional(object({<br>      name                   = string<br>      zone_id                = string<br>      evaluate_target_health = bool<br>    }))<br><br>    failover_routing_policy = optional(object({<br>      type = string<br>    }))<br><br>    geolocation_routing_policy = optional(object({<br>      continent   = optional(string)<br>      country     = optional(string)<br>      subdivision = optional(string)<br>    }))<br><br>    latency_routing_policy = optional(object({<br>      region = string<br>    }))<br><br>    weighted_routing_policy = optional(object({<br>      weight = number<br>    }))<br><br>    multivalue_answer_routing_policy = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_terragrunt_tags"></a> [terragrunt\_tags](#input\_terragrunt\_tags) | tags added by terragrunt automatically | `map(string)` | `{}` | no |
| <a name="input_vpc_ids"></a> [vpc\_ids](#input\_vpc\_ids) | (Optional) A list of IDs of VPCs to associate with a private hosted zone. Conflicts with the delegation\_set\_id. | `list(string)` | `[]` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | (Optional) A zone ID to create the records in | `string` | `null` | no |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | (Required) The name of the hosted zone(s). To create multiple zones at once, pass a list of names ["zone1", "zone2"]. | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route53_record_fqdn"></a> [route53\_record\_fqdn](#output\_route53\_record\_fqdn) | fqdn built using the zone domain and name |
| <a name="output_route53_record_name"></a> [route53\_record\_name](#output\_route53\_record\_name) | the name of the record |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | vpc id acting as primary associated vpc for private hosted zone |
| <a name="output_zone"></a> [zone](#output\_zone) | PHZ Object |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.8 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_route53_hosted_zone_dnssec.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_hosted_zone_dnssec) | resource |
| [aws_route53_key_signing_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_key_signing_key) | resource |
| [aws_route53_record.record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.phz](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_overwrite"></a> [allow\_overwrite](#input\_allow\_overwrite) | (Optional) Default allow\_overwrite value valid for all record sets. | `bool` | `false` | no |
| <a name="input_create_phz"></a> [create\_phz](#input\_create\_phz) | (Optional) Defines whether to create the PHZ or not. Useful in consul env's where resolver rule is preferred. (Default: False) | `bool` | `false` | no |
| <a name="input_default_ttl"></a> [default\_ttl](#input\_default\_ttl) | (Optional) The default TTL ( Time to Live ) in seconds that will be used for all records that support the ttl parameter. Will be overwritten by the records ttl parameter if set. | `number` | `3600` | no |
| <a name="input_enable_dnssec"></a> [enable\_dnssec](#input\_enable\_dnssec) | (Optional) Defines whether to create the DNSSEC keys or not for public hosted zones. (Default: True) | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | (Optional) Whether to force destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone. | `bool` | `false` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_records"></a> [records](#input\_records) | (Optional) A list of records to create in the Hosted Zone. | <pre>list(object({<br>    name            = string<br>    type            = string<br>    ttl             = optional(number) # required for non-alias records<br>    records         = optional(list(string)) # required for non-alias records<br>    zone_id         = optional(string)<br>    set_identifier  = optional(string)<br>    health_check_id = optional(string)<br><br>    alias = optional(object({<br>      name                   = string<br>      zone_id                = string<br>      evaluate_target_health = bool<br>    }))<br><br>    failover_routing_policy = optional(object({<br>      type = string<br>    }))<br><br>    geolocation_routing_policy = optional(object({<br>      continent   = optional(string)<br>      country     = optional(string)<br>      subdivision = optional(string)<br>    }))<br><br>    latency_routing_policy = optional(object({<br>      region = string<br>    }))<br><br>    weighted_routing_policy = optional(object({<br>      weight = number<br>    }))<br><br>    multivalue_answer_routing_policy = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
| <a name="input_terragrunt_tags"></a> [terragrunt\_tags](#input\_terragrunt\_tags) | tags added by terragrunt automatically | `map(string)` | `{}` | no |
| <a name="input_vpc_ids"></a> [vpc\_ids](#input\_vpc\_ids) | (Optional) A list of IDs of VPCs to associate with a private hosted zone. Conflicts with the delegation\_set\_id. | `list(string)` | `[]` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | (Optional) A zone ID to create the records in | `string` | `null` | no |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | (Required) The name of the hosted zone(s). To create multiple zones at once, pass a list of names ["zone1", "zone2"]. | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route53_record_fqdn"></a> [route53\_record\_fqdn](#output\_route53\_record\_fqdn) | fqdn built using the zone domain and name |
| <a name="output_route53_record_name"></a> [route53\_record\_name](#output\_route53\_record\_name) | the name of the record |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | vpc id acting as primary associated vpc for private hosted zone |
| <a name="output_zone"></a> [zone](#output\_zone) | PHZ Object |
<!-- END_TF_DOCS -->
