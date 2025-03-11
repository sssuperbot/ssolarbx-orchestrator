resource "digitalocean_vpc" "custom_vpc" {
  count       = var.enabled_do ? length(data.digitalocean_vpc.existing_vpc[0].id) > 0 ? 0 : 1 : 0
  name        = var.vpc_name
  region      = var.region
  description = "Custom VPC for secure networking"
  ip_range    = var.vpc_ip_rang
}

