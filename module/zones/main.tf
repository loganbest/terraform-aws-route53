data "aws_region" "this" {}

###############################
### R53 Private Hosted Zone ###
###############################

locals {
  zones              = var.zone_name == null ? [] : try(tolist(var.zone_name), [tostring(var.zone_name)], [])
  skip_zone_creation = (length(local.zones) == 0 || !var.create_phz)
}

resource "aws_route53_zone" "phz" {
  #checkov:skip=CKV2_AWS_39:Not enabling query logging for zones. Only internal resolvers.
  for_each = (length(local.zones) > 0 && var.create_phz) ? toset(local.zones) : []

  name          = each.value
  force_destroy = var.force_destroy

  dynamic "vpc" {
    for_each = { for id in var.vpc_ids : id => id }

    content {
      vpc_id = vpc.value
    }
  }

  lifecycle {
    ignore_changes = [vpc]
  }

  tags = merge(
    {
      Name = each.value
    },
    var.tags,
    var.terragrunt_tags
  )
}

###################
### R53 Records ###
###################

locals {
  # prepare the records
  records_expanded = {
    for i, record in var.records : join("-", compact([
      lower(record.type),
      try(lower(record.set_identifier), ""),
      try(lower(record.failover), ""),
      try(lower(record.name), ""),
      ])) => {
      type = record.type
      name = try(record.name, "")
      ttl  = try(record.ttl, null)
      alias = {
        name                   = try(record.alias.name, null)
        zone_id                = try(record.alias.zone_id, null)
        evaluate_target_health = try(record.alias.evaluate_target_health, null)
      }
      allow_overwrite = try(record.allow_overwrite, var.allow_overwrite)
      health_check_id = try(record.health_check_id, null)
      idx             = i
      set_identifier  = try(record.set_identifier, null)
      weight          = try(record.weight, null)
      failover        = try(record.failover, null)
    }
  }

  records_by_name = {
    for product in setproduct(local.zones, keys(local.records_expanded)) : "${product[1]}-${product[0]}" => {
      zone_id         = try(aws_route53_zone.phz[product[0]].id, null)
      type            = local.records_expanded[product[1]].type
      name            = local.records_expanded[product[1]].name
      ttl             = local.records_expanded[product[1]].ttl
      alias           = local.records_expanded[product[1]].alias
      allow_overwrite = local.records_expanded[product[1]].allow_overwrite
      health_check_id = local.records_expanded[product[1]].health_check_id
      idx             = local.records_expanded[product[1]].idx
      set_identifier  = local.records_expanded[product[1]].set_identifier
      weight          = local.records_expanded[product[1]].weight
      failover        = local.records_expanded[product[1]].failover
    }
  }

  records_by_zone_id = {
    for id, record in local.records_expanded : id => {
      zone_id         = var.zone_id
      type            = record.type
      name            = record.name
      ttl             = record.ttl
      alias           = record.alias
      allow_overwrite = record.allow_overwrite
      health_check_id = record.health_check_id
      idx             = record.idx
      set_identifier  = record.set_identifier
      weight          = record.weight
      failover        = record.failover
    }
  }

  records = local.skip_zone_creation ? local.records_by_zone_id : local.records_by_name
}

resource "aws_route53_record" "record" {
  for_each = length(var.records) == 0 ? {} : local.records

  zone_id         = each.value.zone_id
  type            = each.value.type
  name            = each.value.name
  allow_overwrite = each.value.allow_overwrite
  health_check_id = each.value.health_check_id
  set_identifier  = each.value.set_identifier

  # only set default TTL when not set and not alias record
  ttl = each.value.ttl == null && each.value.alias.name == null ? var.default_ttl : each.value.ttl

  # split TXT records at 255 chars to support >255 char records
  records = can(var.records[each.value.idx].records) ? [for r in var.records[each.value.idx].records :
    each.value.type == "TXT" && length(regexall("(\\\"\\\")", r)) == 0 ?
    join("\"\"", compact(split("{SPLITHERE}", replace(r, "/(.{255})/", "$1{SPLITHERE}")))) : r
  ] : null

  dynamic "weighted_routing_policy" {
    for_each = each.value.weight == null ? [] : [each.value.weight]

    content {
      weight = weighted_routing_policy.value
    }
  }

  dynamic "failover_routing_policy" {
    for_each = each.value.failover == null ? [] : [each.value.failover]

    content {
      type = failover_routing_policy.value
    }
  }

  dynamic "alias" {
    for_each = each.value.alias.name == null ? [] : [each.value.alias]

    content {
      name                   = alias.value.name
      zone_id                = alias.value.zone_id
      evaluate_target_health = alias.value.evaluate_target_health
    }
  }
}
