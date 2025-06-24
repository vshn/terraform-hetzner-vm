variable "name_prefix" {
  description = "Prefix for naming the VM and volume"
  type        = string
}

variable "stage" {
  description = "Environment stage (e.g., dev, prod)"
  type        = string
}

variable "domain" {
  description = "Base domain name"
  type        = string
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "image" {
  type    = string
  default = "ubuntu-22.04"
}

variable "server_type" {
  type    = string
  default = "cpx31"
}

variable "location" {
  type    = string
  default = "fsn1"
}

variable "ssh_keys" {
  type    = list(string)
  default = []
}

variable "volume" {
  description = "Optional volume configuration"
  type = object({
    enabled = bool
    size    = number
  })
  default = {
    enabled = false
    size    = 0
  }
}

variable "network_prefix" {
  description = "Prefix for the private IP (e.g., 10.0.2)"
  type        = string
  default     = "10.0.2"
}

variable "network_id" {
  description = "Hetzner network ID to attach to"
  type        = string
}

variable "ip_offset" {
  description = "Offset added to base IP for per-instance address"
  type        = number
  default     = 30
}

variable "depends_on_resource" {
  description = "Explicit dependency (e.g., subnet)"
  type        = any
  default     = null
}

variable "public_net_config" {
  description = "Configure public networking (IPv4/IPv6)"
  type = object({
    ipv4_enabled = bool
    ipv6_enabled = bool
  })
  default = {
    ipv4_enabled = false
    ipv6_enabled = false
  }
}
