variable "name" {
  description = "Base name for the TGW and related resources."
  type        = string
}
variable "amazon_side_asn" {
  description = "Private ASN for the TGW (e.g., 64512-65534 or 4200000000-4294967294)."
  type        = number
  default     = 64512
}
variable "auto_accept_shared_attachments" {
  description = "Enable auto-accept for shared attachments."
  type        = string
  default     = "enable"
  validation {
    condition     = contains(["enable", "disable"], var.auto_accept_shared_attachments)
    error_message = "auto_accept_shared_attachments must be 'enable' or 'disable'."
  }
}
variable "default_route_table_association" {
  description = "Default association behavior for attachments."
  type        = string
  default     = "disable"
  validation {
    condition     = contains(["enable", "disable"], var.default_route_table_association)
    error_message = "default_route_table_association must be 'enable' or 'disable'."
  }
}
variable "default_route_table_propagation" {
  description = "Default propagation behavior for attachments."
  type        = string
  default     = "disable"
  validation {
    condition     = contains(["enable", "disable"], var.default_route_table_propagation)
    error_message = "default_route_table_propagation must be 'enable' or 'disable'."
  }
}
variable "dns_support" {
  description = "Enable DNS support on TGW."
  type        = string
  default     = "enable"
  validation {
    condition     = contains(["enable", "disable"], var.dns_support)
    error_message = "dns_support must be 'enable' or 'disable'."
  }
}

variable "vpn_ecmp_support" {
  description = "Enable VPN ECMP support."
  type        = string
  default     = "enable"
  validation {
    condition     = contains(["enable", "disable"], var.vpn_ecmp_support)
    error_message = "vpn_ecmp_support must be 'enable' or 'disable'."
  }
}
variable "multicast_support" {
  description = "Enable multicast support."
  type        = string
  default     = "disable"
  validation {
    condition     = contains(["enable", "disable"], var.multicast_support)
    error_message = "multicast_support must be 'enable' or 'disable'."
  }
}
variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {}
}
