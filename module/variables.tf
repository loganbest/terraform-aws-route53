#######################################################################
# CloudPosse variables
#######################################################################
# these are needed since we are calling a submodule

variable "namespace" {
  type        = string
  default     = null
  description = "ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique"
}

variable "environment" {
  type        = string
  default     = null
  description = "ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT'"
}

variable "stage" {
  type        = string
  default     = null
  description = "ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release'"
}

#variable "name" {
  #type        = string
  #default     = null
  #description = <<-EOT
    #ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.
    #This is the only ID element not also included as a `tag`.
    #The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input.
    #EOT
#}

variable "tenant" {
  type        = string
  default     = null
  description = "ID element _(Rarely used, not included by default)_. A customer identifier, indicating who this instance of a resource is for"
}

variable "label_order" {
  type        = list(string)
  default     = null
  description = <<-EOT
    The order in which the labels (ID elements) appear in the `id`.
    Defaults to ["namespace", "environment", "stage", "name", "attributes"].
    You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present.
    EOT
}

#######################################################################
# Module variables
#######################################################################

variable "zone_id" {
  description = "(Optional) A zone ID to create the records in"
  type        = string
  default     = null
}

variable "zone_name" {
  description = "(Required) The name of the hosted zone."
  type        = string
  default     = null
}

variable "records" {
  description = "(Optional) A list of records to create in the Hosted Zone."
  type = list(object({
    name            = string
    type            = string
    ttl             = optional(number) # required for non-alias records
    records         = optional(list(string)) # required for non-alias records
    zone_id         = string
    set_identifier  = optional(string)
    health_check_id = optional(string)

    alias = optional(object({
      name                   = string
      zone_id                = string
      evaluate_target_health = bool
    }))

    failover_routing_policy = optional(object({
      type = string
    }))

    geolocation_routing_policy = optional(object({
      continent   = optional(string)
      country     = optional(string)
      subdivision = optional(string)
    }))

    latency_routing_policy = optional(object({
      region = string
    }))

    weighted_routing_policy = optional(object({
      weight = number
    }))

    multivalue_answer_routing_policy = optional(bool)
  }))
  default     = []
}

variable "allow_overwrite" {
  description = "(Optional) Default allow_overwrite value valid for all record sets."
  type        = bool
  default     = false
}

variable "default_ttl" {
  description = "(Optional) The default TTL ( Time to Live ) in seconds that will be used for all records that support the ttl parameter. Will be overwritten by the records ttl parameter if set."
  type        = number
  default     = 3600
}
variable "force_destroy" {
  description = "(Optional) Whether to force destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone."
  type        = bool
  default     = false
}

variable "vpc_ids" {
  description = "(Optional) A list of IDs of VPCs to associate with a private hosted zone. Conflicts with the delegation_set_id."
  type        = list(string)
  default     = []
}

variable "vpc_name" {
  description = "vpc_name (supplied by terragrunt)"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "(Optional) Private Subnet IDs for Resolver Endpoints"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "terragrunt_tags" {
  description = "tags added by terragrunt automatically"
  type        = map(string)
  default     = {}
}

variable "forward_rules" {
  description = <<EOF
    A complex object of map(object()) defining a Forward Rule and their share status.
    'shared' defines if these resolver rules are shared with the entire AWS Org.
    'domain_name' is the domain of the remote PHZ
    'name' is a friendly name for the PHZ, generally the VPC name is fine
    'rule_type' is almost always going to be FORWARD and will default to it
    'target_ips' is a list of IPs where the dns query will be forwarded to. Optionally you can use ['inbound'] to dynamically use the R53 Inbound Endpoint IPs. Really wish tf supported optional params inside objects...
  EOF
  type = object({
    shared = bool
    inbound = map(object({
      domain_name = string
      name        = string
      rule_type   = string
      target_ips  = list(string)
    }))
    outbound = map(object({
      domain_name = string
      name        = string
      rule_type   = string
      target_ips  = list(string)
    }))
  })
  default = {
    shared   = false
    inbound  = {},
    outbound = {}
  }
}

variable "create_phz" {
  description = "(Optional) Defines whether to create the PHZ or not. (Default: False)"
  type        = bool
  default     = false
}

variable "enable_dnssec" {
  description = "(Optional) Defines whether to create the DNSSEC keys or not for public hosted zones. (Default: True)"
  type        = bool
  default     = true
}

variable "enable_resolver_rules" {
  description = "Whether to include Resolver Rules in the VPC"
  type        = bool
  default     = false
}

variable "enable_resolver_inbound_endpoint" {
  description = "Whether to include an Inbound Endpoint in the VPC"
  type        = bool
  default     = false
}

variable "enable_resolver_outbound_endpoint" {
  description = "Whether to include an Outbound Endpoint in the VPC"
  type        = bool
  default     = false
}
