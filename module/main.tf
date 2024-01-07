#########################################
### R53 Private Hosted Zone & Records ###
#########################################

locals {
  zones = var.zone_name == null ? [] : try(tolist(var.zone_name), [tostring(var.zone_name)], [])
}

module "zones" {
  count  = (var.create_phz || length(local.zones) > 0) ? 1 : 0
  source = "./zones"

  vpc_ids  = var.vpc_ids
  vpc_name = var.vpc_name

  create_phz      = var.create_phz
  enable_dnssec   = var.enable_dnssec
  zone_id         = var.zone_id
  zone_name       = var.zone_name
  records         = var.records
  allow_overwrite = var.allow_overwrite
  default_ttl     = var.default_ttl
  force_destroy   = var.force_destroy

  label_order = var.label_order
  namespace   = var.namespace
  environment = var.environment
  stage       = var.stage
  tenant      = var.tenant
  tags = merge(
    var.tags,
    var.terragrunt_tags
  )
}

#########################
###  R53 Endpoint's  ####
#########################

module "endpoints" {
  count  = (var.enable_resolver_inbound_endpoint || var.enable_resolver_outbound_endpoint) ? 1 : 0
  source = "./endpoints"

  vpc_ids    = var.vpc_ids
  vpc_name   = var.vpc_name
  subnet_ids = var.subnet_ids

  label_order = var.label_order
  namespace   = var.namespace
  environment = var.environment
  stage       = var.stage
  tenant      = var.tenant
  tags = merge(
    var.tags,
    var.terragrunt_tags
  )
}

##########################
### R53 Resolver Rules ###
### (Non-Consul Envs)  ###
##########################

module "resolver_rules" {
  count  = (var.enable_resolver_rules && !var.create_phz) ? 1 : 0
  source = "./resolver_rules"

  vpc_ids  = var.vpc_ids
  vpc_name = var.vpc_name

  forward_rules = var.forward_rules

  label_order = var.label_order
  namespace   = var.namespace
  environment = var.environment
  stage       = var.stage
  tenant      = var.tenant
  tags = merge(
    var.tags,
    var.terragrunt_tags
  )
}
