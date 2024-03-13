output "zone" {
  description = "PHZ Object"
  value = (length(aws_route53_zone.phz) > 0) ? {
    name    = aws_route53_zone.phz[var.zone_name].name
    zone_id = aws_route53_zone.phz[var.zone_name].zone_id
    arn     = aws_route53_zone.phz[var.zone_name].arn
    vpc     = aws_route53_zone.phz[var.zone_name].vpc
  } : null
}

output "vpc_id" {
  description = "vpc id acting as primary associated vpc for private hosted zone"
  value       = try(var.vpc_ids, null)
}

output "route53_record_name" {
  description = "the name of the record"
  value       = { for k, v in aws_route53_record.record : k => v.name }
}

output "route53_record_fqdn" {
  description = "fqdn built using the zone domain and name"
  value       = { for k, v in aws_route53_record.record : k => v.fqdn }
}
