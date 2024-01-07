output "resolver_inbound_endpoint" {
  description = "Resolver Inbound Endpoint full output"
  value       = aws_route53_resolver_endpoint.rr_inbound
}

output "resolver_outbound_endpoint" {
  description = "Resolver Outbound Endpoint full output"
  value       = aws_route53_resolver_endpoint.rr_outbound
}
