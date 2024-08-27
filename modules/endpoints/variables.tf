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

variable "terragrunt_tags" {
  description = "tags added by terragrunt automatically"
  type        = map(string)
  default     = {}
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

variable "endpoint_allow_cidrs" {
  description = "(Optional) IP CIDR's to allow to reach the Resolver Endpoints"
  type        = list(string)
  default     = ["10.0.0.0/8"]
}
