variable "zone_id" {
  description = "(Optional) A zone ID to create the records in"
  type        = string
  default     = null
}

variable "zone_name" {
  description = "(Required) The name of the hosted zone(s). To create multiple zones at once, pass a list of names [\"zone1\", \"zone2\"]."
  type        = any
  default     = null
}

variable "records" {
  description = "(Optional) A list of records to create in the Hosted Zone."
  type = list(object({
    name            = string
    type            = string
    ttl             = optional(number)       # required for non-alias records
    records         = optional(list(string)) # required for non-alias records
    zone_id         = optional(string)
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
  default = []
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

variable "terragrunt_tags" {
  description = "tags added by terragrunt automatically"
  type        = map(string)
  default     = {}
}

variable "create_phz" {
  description = "(Optional) Defines whether to create the PHZ or not. Useful in consul env's where resolver rule is preferred. (Default: False)"
  type        = bool
  default     = false
}

variable "enable_dnssec" {
  description = "(Optional) Defines whether to create the DNSSEC keys or not for public hosted zones. (Default: True)"
  type        = bool
  default     = true
}
