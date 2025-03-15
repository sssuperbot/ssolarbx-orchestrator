variable "do_token" {
  description = "DigitalOcean API Token"
  type        = string
  sensitive   = true
  default     = ""
}

variable "vultr_token" {
  description = "Vultr API Token"
  type        = string
  sensitive   = true
  default     = ""
}

variable "region" {
  description = "DigitalOcean region"
  type        = string
  default     = "nyc1"
}

variable "droplet_size" {
  description = "Size of the droplet"
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "droplet_name" {
  description = "Name of the Droplet"
  type        = string
  default     = "bot-sol-1vcpu-1gb-nyc1"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "my-vpc"
}

variable "droplet_count" {
  type    = string
  default = "01"
}

variable "firewall_name" {
  type    = string
  default = "fname"
}

variable "image" {
  description = "OS image to use for the Droplet"
  type        = string
  default     = "ubuntu-24-04-x64"
}

variable "enable_ipv6" {
  description = "Enable IPv6"
  type        = bool
  default     = true
}

variable "enable_monitoring" {
  description = "Enable DigitalOcean monitoring"
  type        = bool
  default     = true
}

variable "firewall_port_22" {
  type    = list(string)
  default = ["0.0.0.0/0", "::/0"]
}

variable "vpc_ip_rang" {
  type    = string
  default = "10.0.0.0/16"
}

variable "existing_ssh_key_name" {
  description = "Name of the existing SSH key in DigitalOcean"
  type        = string
}

variable "solarbx_ssh_key_path" {
  type    = string
  default = "~/.ssh/solarbx.pub"
}

variable "project_name" {
  type    = string
  default = ""
}
variable "create_firewall" {
  type    = number
  default = 0
}

variable "enabled_vultr" {
  type    = bool
  default = false
}

variable "enabled_do" {
  type    = bool
  default = true
}

variable "enabled_vultr_multiple_ip" {
  type    = bool
  default = false
}

variable "count_vultr_multiple_ip" {
  type    = number
  default = 1
}

variable "droplet_configs" {
  type = map(object({
    region                   = string
    size                     = string
    image                    = string
    keypair                  = string
    bot_version              = string
    swap_threads             = optional(number)
    mint                     = optional(string)
    mint_decimal             = optional(number)
    jupiter_url              = optional(string)
    jupiter_api_key          = optional(string)
    min_spend                = optional(number)
    max_spend                = optional(number)
    jupiter_delay            = optional(number)
    jito_static_tip_lamports = optional(number)
    jito_static_tip_percent  = optional(number)
    auto_max_spend           = optional(bool)
    cu_limit_per_route       = optional(number)
    proxy_wallet             = optional(bool)
    transfer_proxy_lamports  = optional(number)
    proxy_cu_limit           = optional(number)
    static_mints_enabled     = optional(bool)
    static_mints             = optional(list(string))
    min_gain                 = optional(number)
    wrap_and_unwrap_sol      = optional(bool)
    only_direct_routes       = optional(bool)
    jito_configs = optional(list(object({
      enabled = bool
      url     = string
    })))
  }))
  default = {}
}

variable "ansible_user" {
  type = string
}
