variable "vpc_ids" {
  description = "(Optional) A list of IDs of VPCs to associate with a private hosted zone. Conflicts with the delegation_set_id."
  type        = list(string)
  default     = []
}

variable "terragrunt_tags" {
  description = "tags added by terragrunt automatically"
  type        = map(string)
  default     = {}
}

variable "forward_rules" {
  description = <<EOF
A complex object of map(object()) defining a Forward Rule and their share status.
'shared' defines if these resolver rules are shared with the entire AWS Org. Only valid inside the Authoritative Account (Default: False)
'domain_name' is the domain of the remote PHZ
'name' is a friendly name for the PHZ, generally the VPC name is fine
'rule_type' is almost always going to be FORWARD and will default to it
'target_ips' is a list of IPs where the dns query will be forwarded to.
EOF
  type = object({
    shared = optional(bool, true)
    inbound = map(object({
      domain_name = string
      name        = string
      rule_type   = optional(string, "FORWARD")
      target_ips  = list(string)
      endpoint_id = string
    }))
    outbound = map(object({
      domain_name = string
      name        = string
      rule_type   = optional(string, "FORWARD")
      target_ips  = list(string)
      endpoint_id = string
    }))
  })
  default = {
    shared   = false
    inbound  = {},
    outbound = {}
  }
}

variable "is_authoritative_account" {
  description = "Boolean to define whether this is in Authoritative account or not (Default: False)"
  type        = bool
  default     = false
}
