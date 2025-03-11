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
    region = string
    size   = string
    image  = string
  }))
  default = {}
}

variable "ansible_user" {
  type = string
}

variable "keypair" {
  type = string
}

variable "swap_threads" {
  type = number
  default = 2
}
