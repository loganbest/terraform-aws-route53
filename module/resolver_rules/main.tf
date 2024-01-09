#data "aws_organizations_organization" "this" {}

#data "aws_region" "this" {}

#data "aws_vpc" "netsvc_use1" {
  #provider = aws.net_prod_use1
  #tags = {
    #Name = "p-use1-vpc-networking-dns"
  #}
#}

#data "aws_vpc" "netsvc_use2" {
  #provider = aws.net_prod_use2
  #tags = {
    #Name = "p-use2-vpc-networking-dns"
  #}
#}

#data "aws_route53_resolver_endpoint" "netsvc_inbound" {
  #provider = aws.net_prod
  #filter {
    #name   = "DIRECTION"
    #values = ["INBOUND"]
  #}
#}

#data "aws_route53_resolver_endpoint" "netsvc_outbound" {
  #provider = aws.net_prod
  #filter {
    #name   = "DIRECTION"
    #values = ["OUTBOUND"]
  #}
#}

#data "aws_route53_resolver_endpoint" "netsvc_use1_inbound" {
  #provider = aws.net_prod_use1
  #filter {
    #name   = "DIRECTION"
    #values = ["INBOUND"]
  #}
#}

#data "aws_route53_resolver_endpoint" "netsvc_use2_inbound" {
  #provider = aws.net_prod_use2
  #filter {
    #name   = "DIRECTION"
    #values = ["INBOUND"]
  #}
#}

#data "aws_route53_resolver_endpoint" "netsvc_use1_outbound" {
  #provider = aws.net_prod_use1
  #filter {
    #name   = "DIRECTION"
    #values = ["OUTBOUND"]
  #}
#}

#data "aws_route53_resolver_endpoint" "netsvc_use2_outbound" {
  #provider = aws.net_prod_use2
  #filter {
    #name   = "DIRECTION"
    #values = ["OUTBOUND"]
  #}
#}

################################
####   R53 Resolver Rules    ###
#### (Static Regional Rules) ###
################################

#resource "aws_route53_resolver_rule" "rr_fwd_inbound" {
  #for_each             = { for k, v in var.forward_rules.inbound : k => v if(var.is_netsvc_account) }
  #domain_name          = var.forward_rules.inbound[each.key].domain_name
  #name                 = var.forward_rules.inbound[each.key].name
  #rule_type            = (try(var.forward_rules.inbound[each.key].rule_type, null) != null) ? var.forward_rules.inbound[each.key].rule_type : "FORWARD"
  #resolver_endpoint_id = data.aws_route53_resolver_endpoint.netsvc_outbound.resolver_endpoint_id

  #dynamic "target_ip" {
    #for_each = { for k, v in data.aws_route53_resolver_endpoint.netsvc_inbound.ip_addresses : k => v if each.value.target_ips[0] == "inbound" }

    #content {
      #ip = target_ip.value
    #}
  #}

  #tags = merge(
    #var.tags,
    #var.terragrunt_tags
  #)
#}

#resource "aws_route53_resolver_rule" "rr_fwd_outbound" {
  #for_each             = { for k, v in var.forward_rules.outbound : k => v if(var.is_netsvc_account) }
  #domain_name          = var.forward_rules.outbound[each.key].domain_name
  #name                 = var.forward_rules.outbound[each.key].name
  #rule_type            = (try(var.forward_rules.outbound[each.key].rule_type, null) != null) ? var.forward_rules.outbound[each.key].rule_type : "FORWARD"
  #resolver_endpoint_id = data.aws_route53_resolver_endpoint.netsvc_outbound.resolver_endpoint_id

  #dynamic "target_ip" {
    #for_each = { for k, v in each.value.target_ips : k => v if each.value.target_ips[0] != "inbound" }

    #content {
      #ip = target_ip.value
    #}
  #}

  #tags = merge(
    #var.tags,
    #var.terragrunt_tags
  #)
#}

#resource "aws_route53_resolver_rule_association" "rr_assoc" {
  #for_each         = (var.is_netsvc_account) ? aws_route53_resolver_rule.rr_fwd_outbound : {}
  #resolver_rule_id = aws_route53_resolver_rule.rr_fwd_outbound[each.key].id
  #vpc_id           = var.vpc_ids[0]
#}

#############################
####  R53 Resolver Rules  ###
#### (External Resolvers) ###
#############################

#resource "aws_route53_resolver_rule" "rr_fwd_ext_outbound_use1" {
  #provider             = aws.net_prod_use1
  #for_each             = { for k, v in var.forward_rules.outbound : k => v if(!var.is_netsvc_account) }
  #domain_name          = var.forward_rules.outbound[each.key].domain_name
  #name                 = var.forward_rules.outbound[each.key].name
  #rule_type            = (try(var.forward_rules.outbound[each.key].rule_type, null) != null) ? var.forward_rules.outbound[each.key].rule_type : "FORWARD"
  #resolver_endpoint_id = data.aws_route53_resolver_endpoint.netsvc_use1_outbound.resolver_endpoint_id

  #dynamic "target_ip" {
    #for_each = { for k, v in each.value.target_ips : k => v if each.value.target_ips[0] != "inbound" }

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
  #for_each             = { for k, v in var.forward_rules.outbound : k => v if(!var.is_netsvc_account) }
  #domain_name          = var.forward_rules.outbound[each.key].domain_name
  #name                 = var.forward_rules.outbound[each.key].name
  #rule_type            = (try(var.forward_rules.outbound[each.key].rule_type, null) != null) ? var.forward_rules.outbound[each.key].rule_type : "FORWARD"
  #resolver_endpoint_id = data.aws_route53_resolver_endpoint.netsvc_use2_outbound.resolver_endpoint_id

  #dynamic "target_ip" {
    #for_each = { for k, v in each.value.target_ips : k => v if each.value.target_ips[0] != "inbound" }

    #content {
      #ip = target_ip.value
    #}
  #}

  #tags = merge(
    #var.tags,
    #var.terragrunt_tags
  #)
#}

#resource "aws_route53_resolver_rule_association" "rr_ext_netsvc_use1_assoc" {
  #provider         = aws.net_prod_use1
  #for_each         = { for k, v in aws_route53_resolver_rule.rr_fwd_ext_outbound_use1 : k => v if(!var.is_netsvc_account) }
  #resolver_rule_id = each.value.id
  #vpc_id           = data.aws_vpc.netsvc_use1.id
#}

#resource "aws_route53_resolver_rule_association" "rr_ext_netsvc_use2_assoc" {
  #provider = aws.net_prod_use2
  #for_each = { for k, v in aws_route53_resolver_rule.rr_fwd_ext_outbound_use2 : k => v if(!var.
  #is_netsvc_account) }
  #resolver_rule_id = each.value.id
  #vpc_id           = data.aws_vpc.netsvc_use2.id
#}

###################################################################################
####                       Resolver Rule Sharing                                ###
##        (Global Rules Originating from the Network Services account)            #
##  If we're in the netsvc account, share the resolver rules with the entire org  #
###################################################################################

#resource "aws_ram_resource_share" "this" {
  #provider = aws.net_prod
  #count    = (var.is_netsvc_account && var.forward_rules.shared) ? 1 : 0
  #name     = "NetSvc-ResolverRules-OrgShare"

  #tags = merge(
    #{
      #Name = "NetSvc-ResolverRules-OrgShare"
    #},
    #var.terragrunt_tags
  #)
#}

#resource "aws_ram_resource_association" "this" {
  #provider = aws.net_prod
  #for_each = (var.is_netsvc_account && var.forward_rules.shared) ? merge(aws_route53_resolver_rule.rr_fwd_inbound, aws_route53_resolver_rule.rr_fwd_outbound) : {}

  #resource_share_arn = aws_ram_resource_share.this.0.arn
  #resource_arn       = each.value.arn
#}

#resource "aws_ram_principal_association" "this" {
  #provider = aws.net_prod
  #count    = (var.is_netsvc_account && var.forward_rules.shared) ? 1 : 0

  #resource_share_arn = aws_ram_resource_share.this.0.arn
  #principal          = data.aws_organizations_organization.this.arn
#}
