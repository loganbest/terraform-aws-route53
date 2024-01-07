# resolver_rules

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.23.1 |
| <a name="provider_aws.net_prod"></a> [aws.net\_prod](#provider\_aws.net\_prod) | 5.23.1 |
| <a name="provider_aws.net_prod_use1"></a> [aws.net\_prod\_use1](#provider\_aws.net\_prod\_use1) | 5.23.1 |
| <a name="provider_aws.net_prod_use2"></a> [aws.net\_prod\_use2](#provider\_aws.net\_prod\_use2) | 5.23.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ram_principal_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_resource_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_share.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_route53_resolver_rule.rr_fwd_ext_outbound_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule) | resource |
| [aws_route53_resolver_rule.rr_fwd_ext_outbound_use2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule) | resource |
| [aws_route53_resolver_rule.rr_fwd_inbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule) | resource |
| [aws_route53_resolver_rule.rr_fwd_outbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule) | resource |
| [aws_route53_resolver_rule_association.rr_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_route53_resolver_rule_association.rr_ext_netsvc_use1_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_route53_resolver_rule_association.rr_ext_netsvc_use2_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_organizations_organization.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_route53_resolver_endpoint.netsvc_inbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_resolver_endpoint) | data source |
| [aws_route53_resolver_endpoint.netsvc_outbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_resolver_endpoint) | data source |
| [aws_route53_resolver_endpoint.netsvc_use1_inbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_resolver_endpoint) | data source |
| [aws_route53_resolver_endpoint.netsvc_use1_outbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_resolver_endpoint) | data source |
| [aws_route53_resolver_endpoint.netsvc_use2_inbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_resolver_endpoint) | data source |
| [aws_route53_resolver_endpoint.netsvc_use2_outbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_resolver_endpoint) | data source |
| [aws_vpc.netsvc_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [aws_vpc.netsvc_use2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_resolver_rules"></a> [enable\_resolver\_rules](#input\_enable\_resolver\_rules) | Whether to include Resolver Rules in the VPC | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_forward_rules"></a> [forward\_rules](#input\_forward\_rules) | A complex object of map(object()) defining a Forward Rule and their share status.<br>    'shared' defines if these resolver rules are shared with the entire Gemini AWS Org. Only valid inside Network Services Account (Default: False)<br>    'domain\_name' is the domain of the remote PHZ<br>    'name' is a friendly name for the PHZ, generally the VPC name is fine<br>    'rule\_type' is almost always going to be FORWARD and will default to it<br>    'target\_ips' is a list of IPs where the dns query will be forwarded to. Optionally you can use ['inbound'] to dynamically use the R53 Inbound Endpoint IPs. Really wish tf supported optional params inside objects... | <pre>object({<br>    shared = bool<br>    inbound = map(object({<br>      domain_name = string<br>      name        = string<br>      rule_type   = string<br>      target_ips  = list(string)<br>    }))<br>    outbound = map(object({<br>      domain_name = string<br>      name        = string<br>      rule_type   = string<br>      target_ips  = list(string)<br>    }))<br>  })</pre> | <pre>{<br>  "inbound": {},<br>  "outbound": {},<br>  "shared": false<br>}</pre> | no |
| <a name="input_is_netsvc_account"></a> [is\_netsvc\_account](#input\_is\_netsvc\_account) | Boolean to define whether this is in Network Services account or not (Default: False) | `bool` | `false` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
| <a name="input_terragrunt_tags"></a> [terragrunt\_tags](#input\_terragrunt\_tags) | tags added by terragrunt automatically | `map(string)` | `{}` | no |
| <a name="input_vpc_ids"></a> [vpc\_ids](#input\_vpc\_ids) | (Optional) A list of IDs of VPCs to associate with a private hosted zone. Conflicts with the delegation\_set\_id. | `list(string)` | `[]` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | vpc\_name (supplied by terragrunt) | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route53_resolver_rule_arn"></a> [route53\_resolver\_rule\_arn](#output\_route53\_resolver\_rule\_arn) | Resolver Rule ARN |
| <a name="output_route53_resolver_rule_id"></a> [route53\_resolver\_rule\_id](#output\_route53\_resolver\_rule\_id) | Resolver Rule ID |
| <a name="output_route53_resolver_rule_owner_id"></a> [route53\_resolver\_rule\_owner\_id](#output\_route53\_resolver\_rule\_owner\_id) | Resolver Rule Account Owner ID |
| <a name="output_route53_resolver_rule_share_status"></a> [route53\_resolver\_rule\_share\_status](#output\_route53\_resolver\_rule\_share\_status) | Resolver Rule Share Status |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
