output "resolver_inbound_endpoint" {
  description = "Resolver Inbound Endpoint full output"
  value       = try(aws_route53_resolver_endpoint.rr_inbound[0], null)
}

output "resolver_outbound_endpoint" {
  description = "Resolver Outbound Endpoint full output"
  value       = try(aws_route53_resolver_endpoint.rr_outbound[0], null)
}
