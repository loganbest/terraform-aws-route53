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
