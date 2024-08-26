data "aws_organizations_organization" "this" {}

data "aws_region" "this" {}

######################################################################
###                        R53 Resolver Rules                      ###
### (Static Regional Rules applied from the Authoritative Account) ###
######################################################################

resource "aws_route53_resolver_rule" "rr_fwd_inbound" {
  for_each             = { for k, v in var.forward_rules.inbound : k => v if(var.is_authoritative_account) }
  domain_name          = each.value.domain_name
  name                 = each.value.name
  rule_type            = each.value.rule_type
  resolver_endpoint_id = each.value.endpoint_id

  dynamic "target_ip" {
    for_each = { for k, v in each.value.target_ips : k => v }

    content {
      ip = target_ip.value
    }
  }

  tags = merge(
    var.tags,
    var.terragrunt_tags
  )
}

resource "aws_route53_resolver_rule" "rr_fwd_outbound" {
  for_each             = { for k, v in var.forward_rules.outbound : k => v if(var.is_authoritative_account) }
  domain_name          = each.value.domain_name
  name                 = each.value.name
  rule_type            = each.value.rule_type
  resolver_endpoint_id = each.value.endpoint_id

  dynamic "target_ip" {
    for_each = { for k, v in each.value.target_ips : k => v }

    content {
      ip = target_ip.value
    }
  }

  tags = merge(
    var.tags,
    var.terragrunt_tags
  )
}

resource "aws_route53_resolver_rule_association" "rr_assoc" {
  for_each         = (var.is_authoritative_account) ? aws_route53_resolver_rule.rr_fwd_outbound : {}
  resolver_rule_id = each.value.id
  vpc_id           = var.vpc_ids[0]
}

#############################################################
###                    R53 Resolver Rules                 ###
### (Static rules applied from non Authoritative Account) ###
#############################################################

#resource "aws_route53_resolver_rule" "rr_fwd_ext_outbound_use1" {
#provider             = aws.net_prod_use1
#for_each             = { for k, v in var.forward_rules.outbound : k => v if(!var.is_authoritative_account) }
#domain_name          = each.value.domain_name
#name                 = each.value.name
#rule_type            = each.value.rule_type
#resolver_endpoint_id = each.value.endpoint_id

#dynamic "target_ip" {
#for_each = { for k, v in each.value.target_ips : k => v }

#content {
#ip = target_ip.value
#}
#}

#tags = merge(
#var.tags,
#var.terragrunt_tags
#)
#}

#resource "aws_route53_resolver_rule" "rr_fwd_ext_outbound_use2" {
#provider             = aws.net_prod_use2
#for_each             = { for k, v in var.forward_rules.outbound : k => v if(!var.is_authoritative_account) }
#domain_name          = each.value.domain_name
#name                 = each.value.name
#rule_type            = each.value.rule_type
#resolver_endpoint_id = each.value.endpoint_id

#dynamic "target_ip" {
#for_each = { for k, v in each.value.target_ips : k => v }

#content {
#ip = target_ip.value
#}
#}

#tags = merge(
#var.tags,
#var.terragrunt_tags
#)
#}

#resource "aws_route53_resolver_rule_association" "rr_ext_authoritative_use1_assoc" {
#provider         = aws.net_prod_use1
#for_each         = { for k, v in aws_route53_resolver_rule.rr_fwd_ext_outbound_use1 : k => v if(!var.is_authoritative_account) }
#resolver_rule_id = each.value.id
#vpc_id           = data.aws_vpc.authoritative_use1.id
#}

#resource "aws_route53_resolver_rule_association" "rr_ext_authoritative_use2_assoc" {
#provider = aws.net_prod_use2
#for_each = { for k, v in aws_route53_resolver_rule.rr_fwd_ext_outbound_use2 : k => v if(!var.
#is_authoritative_account) }
#resolver_rule_id = each.value.id
#vpc_id           = data.aws_vpc.authoritative_use2.id
#}

#########################################################################################
###                           Resolver Rule Sharing                                   ###
#           (Global Rules Originating from the Network Services account)                #
#  If we're in the authoritative account, share the resolver rules with the entire org  #
##################################################################################

resource "aws_ram_resource_share" "this" {
  count = (var.is_authoritative_account && var.forward_rules.shared) ? 1 : 0
  name  = "authoritative-ResolverRules-OrgShare"

  tags = merge(
    {
      Name = "ResolverRules-OrgShare"
    },
    var.terragrunt_tags
  )
}

resource "aws_ram_resource_association" "this" {
  for_each = (var.is_authoritative_account && var.forward_rules.shared) ? merge(aws_route53_resolver_rule.rr_fwd_inbound, aws_route53_resolver_rule.rr_fwd_outbound) : {}

  resource_share_arn = aws_ram_resource_share.this.0.arn
  resource_arn       = each.value.arn
}

resource "aws_ram_principal_association" "this" {
  count = (var.is_authoritative_account && var.forward_rules.shared) ? 1 : 0

  resource_share_arn = aws_ram_resource_share.this.0.arn
  principal          = data.aws_organizations_organization.this.arn
}
