# endpoints

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.23.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dns_security_group"></a> [dns\_security\_group](#module\_dns\_security\_group) | cloudposse/security-group/aws | ~> 2.2 |

## Resources

| Name | Type |
|------|------|
| [aws_route53_resolver_endpoint.rr_inbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_endpoint) | resource |
| [aws_route53_resolver_endpoint.rr_outbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_resolver_inbound_endpoint"></a> [enable\_resolver\_inbound\_endpoint](#input\_enable\_resolver\_inbound\_endpoint) | Whether to include an Inbound Endpoint in the VPC | `bool` | `false` | no |
| <a name="input_enable_resolver_outbound_endpoint"></a> [enable\_resolver\_outbound\_endpoint](#input\_enable\_resolver\_outbound\_endpoint) | Whether to include an Outbound Endpoint in the VPC | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | (Optional) Private Subnet IDs for Resolver Endpoints | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
| <a name="input_terragrunt_tags"></a> [terragrunt\_tags](#input\_terragrunt\_tags) | tags added by terragrunt automatically | `map(string)` | `{}` | no |
| <a name="input_vpc_ids"></a> [vpc\_ids](#input\_vpc\_ids) | (Optional) A list of IDs of VPCs to associate with a private hosted zone. Conflicts with the delegation\_set\_id. | `list(string)` | `[]` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | vpc\_name (supplied by terragrunt) | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resolver_inbound_endpoint_arn"></a> [resolver\_inbound\_endpoint\_arn](#output\_resolver\_inbound\_endpoint\_arn) | Resolver Inbound Endpoint ARN |
| <a name="output_resolver_inbound_endpoint_id"></a> [resolver\_inbound\_endpoint\_id](#output\_resolver\_inbound\_endpoint\_id) | Resolver Inbound Endpoint ID |
| <a name="output_resolver_inbound_endpoint_ip_address"></a> [resolver\_inbound\_endpoint\_ip\_address](#output\_resolver\_inbound\_endpoint\_ip\_address) | Resolver Inbound Endpoint Host IP Addresses |
| <a name="output_resolver_inbound_endpoint_vpc_id"></a> [resolver\_inbound\_endpoint\_vpc\_id](#output\_resolver\_inbound\_endpoint\_vpc\_id) | Resolver Inbound Endpoint Host VPC ID |
| <a name="output_resolver_outbound_endpoint_arn"></a> [resolver\_outbound\_endpoint\_arn](#output\_resolver\_outbound\_endpoint\_arn) | Resolver Outbound Endpoint ARN |
| <a name="output_resolver_outbound_endpoint_id"></a> [resolver\_outbound\_endpoint\_id](#output\_resolver\_outbound\_endpoint\_id) | Resolver Outbound Endpoint ID |
| <a name="output_resolver_outbound_endpoint_ip_address"></a> [resolver\_outbound\_endpoint\_ip\_address](#output\_resolver\_outbound\_endpoint\_ip\_address) | Resolver Outbound Endpoint Host IP Addresses |
| <a name="output_resolver_outbound_endpoint_vpc_id"></a> [resolver\_outbound\_endpoint\_vpc\_id](#output\_resolver\_outbound\_endpoint\_vpc\_id) | Resolver Outbound Endpoint Host VPC ID |
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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dns_security_group"></a> [dns\_security\_group](#module\_dns\_security\_group) | cloudposse/security-group/aws | ~> 2.2 |

## Resources

| Name | Type |
|------|------|
| [aws_route53_resolver_endpoint.rr_inbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_endpoint) | resource |
| [aws_route53_resolver_endpoint.rr_outbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_resolver_inbound_endpoint"></a> [enable\_resolver\_inbound\_endpoint](#input\_enable\_resolver\_inbound\_endpoint) | Whether to include an Inbound Endpoint in the VPC | `bool` | `false` | no |
| <a name="input_enable_resolver_outbound_endpoint"></a> [enable\_resolver\_outbound\_endpoint](#input\_enable\_resolver\_outbound\_endpoint) | Whether to include an Outbound Endpoint in the VPC | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | (Optional) Private Subnet IDs for Resolver Endpoints | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
| <a name="input_terragrunt_tags"></a> [terragrunt\_tags](#input\_terragrunt\_tags) | tags added by terragrunt automatically | `map(string)` | `{}` | no |
| <a name="input_vpc_ids"></a> [vpc\_ids](#input\_vpc\_ids) | (Optional) A list of IDs of VPCs to associate with a private hosted zone. Conflicts with the delegation\_set\_id. | `list(string)` | `[]` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | vpc\_name (supplied by terragrunt) | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resolver_inbound_endpoint"></a> [resolver\_inbound\_endpoint](#output\_resolver\_inbound\_endpoint) | Resolver Inbound Endpoint full output |
| <a name="output_resolver_outbound_endpoint"></a> [resolver\_outbound\_endpoint](#output\_resolver\_outbound\_endpoint) | Resolver Outbound Endpoint full output |
<!-- END_TF_DOCS -->