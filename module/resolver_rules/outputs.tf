#output "route53_resolver_rule_id" {
  #description = "Resolver Rule ID"
  #value = merge(
    #{ for k, v in aws_route53_resolver_rule.rr_fwd_inbound : k => v.id },
    #{ for k, v in aws_route53_resolver_rule.rr_fwd_outbound : k => v.id }
  #)
#}

#output "route53_resolver_rule_arn" {
  #description = "Resolver Rule ARN"
  #value = merge(
    #{ for k, v in aws_route53_resolver_rule.rr_fwd_inbound : k => v.arn },
    #{ for k, v in aws_route53_resolver_rule.rr_fwd_outbound : k => v.arn }
  #)
#}

#output "route53_resolver_rule_owner_id" {
  #description = "Resolver Rule Account Owner ID"
  #value = merge(
    #{ for k, v in aws_route53_resolver_rule.rr_fwd_inbound : k => v.owner_id },
    #{ for k, v in aws_route53_resolver_rule.rr_fwd_outbound : k => v.owner_id }
  #)
#}

#output "route53_resolver_rule_share_status" {
  #description = "Resolver Rule Share Status"
  #value = merge(
    #{ for k, v in aws_route53_resolver_rule.rr_fwd_inbound : k => v.share_status },
    #{ for k, v in aws_route53_resolver_rule.rr_fwd_outbound : k => v.share_status }
  #)
#}
