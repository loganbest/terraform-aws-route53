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
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.51.0 |
| <a name="provider_aws.net_prod"></a> [aws.net\_prod](#provider\_aws.net\_prod) | 5.51.0 |
| <a name="provider_aws.net_prod_use1"></a> [aws.net\_prod\_use1](#provider\_aws.net\_prod\_use1) | 5.51.0 |
| <a name="provider_aws.net_prod_use2"></a> [aws.net\_prod\_use2](#provider\_aws.net\_prod\_use2) | 5.51.0 |

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
| [aws_route53_resolver_rule_association.rr_ext_authoritative_use1_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_route53_resolver_rule_association.rr_ext_authoritative_use2_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_organizations_organization.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.8 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->