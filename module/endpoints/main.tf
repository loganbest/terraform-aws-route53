#########################
### R53 Endpoint SG's ###
#########################

module "dns_security_group" {
  source   = "cloudposse/security-group/aws"
  version  = "~> 2.2"
  for_each = { for k, v in toset(var.vpc_ids) : k => v }

  name                       = "dns"
  security_group_description = "dns security group that controls Route53"
  vpc_id                     = each.value

  rules = [
    {
      type        = "ingress"
      description = "Route53 DNS (tcp)"
      from_port   = 53
      to_port     = 53
      protocol    = "tcp"
      cidr_blocks = [
        "10.0.0.0/8", #blanket 10/8
      ]
    },
    {
      type        = "ingress"
      description = "Route53 DNS (udp)"
      from_port   = 53
      to_port     = 53
      protocol    = "udp"
      cidr_blocks = [
        "10.0.0.0/8", #blanket 10/8
      ]
    },
    {
      type        = "egress"
      description = "Route53 DNS (tcp)"
      from_port   = 53
      to_port     = 53
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type        = "egress"
      description = "Route53 DNS (udp)"
      from_port   = 53
      to_port     = 53
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]

  label_order = var.label_order
  namespace   = var.namespace
  environment = var.environment
  stage       = var.stage
  tenant      = var.tenant
  attributes  = ["sg"]
}

##############################
### R53 Resolver Endpoints ###
##############################

resource "aws_route53_resolver_endpoint" "rr_inbound" {
  count  = (var.enable_resolver_inbound_endpoint) ? 1 : 0

  name      = "${var.vpc_name}-inbound"
  direction = "INBOUND"

  security_group_ids = [for sg in module.dns_security_group : sg.id]

  dynamic "ip_address" {
    for_each = var.subnet_ids
    content {
      subnet_id = ip_address.value
    }
  }

  tags = merge(
    var.tags,
    var.terragrunt_tags
  )
}

resource "aws_route53_resolver_endpoint" "rr_outbound" {
  count  = (var.enable_resolver_outbound_endpoint) ? 1 : 0

  name      = "${var.vpc_name}-outbound"
  direction = "OUTBOUND"

  security_group_ids = [for sg in module.dns_security_group : sg.id]

  dynamic "ip_address" {
    for_each = var.subnet_ids
    content {
      subnet_id = ip_address.value
    }
  }

  tags = merge(
    var.tags,
    var.terragrunt_tags
  )
}
