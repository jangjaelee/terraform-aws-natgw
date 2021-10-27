variable "vpc_name" {
  description = "Name to be used on all the resources as identifier for VPC"
  type        = string
}

variable "default_destination" {
  description = "Default route destnation"
  type        = string
  default     = "0.0.0.0/0"
}

variable "az_zone_names" {
  description = "Availability Zone"
  type        = list(string)
}

variable "enable_public_subnet" {
  description = "Indicate whether to create public subnet"
  type        = bool
  default     = true
}

variable "private_sub_env1" {
  description = "Private Sub-Environment 1"
  type        = string
  default     = ""
}

variable "public_sub_env1" {
  description = "Public Sub-Environment 1"
  type        = string
  default     = ""
}

variable "private_sub_env2" {
  description = "Private Sub-Environment 2"
  type        = string
  default     = ""
}

variable "public_sub_env2" {
  description = "Public Sub-Environment 2"
  type        = string
  default     = ""
}

variable "create_natgw" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = true
}

variable "natgw_name" {
  description = "Name of NAT Gateway"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "env" {
  description = "Environment"
  type = string
}