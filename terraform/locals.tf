locals {
  droplet_name     = "${var.droplet_name}-${var.droplet_count}"
  vpc_uuid         = var.enabled_do ? length(data.digitalocean_vpc.existing_vpc[0].id) > 0 ? data.digitalocean_vpc.existing_vpc[0].id : digitalocean_vpc.custom_vpc[0].id : ""
  ssh_key_id       = var.enabled_do ? [for key in data.digitalocean_ssh_keys.existing_keys[0].ssh_keys : key.id if key.name == var.existing_ssh_key_name] : []
  tags             = ["bot", "bot-sol-client-${var.droplet_count}", "sol"]
  ssh_key_id_vultr = var.enabled_vultr == true ? [data.vultr_ssh_key.existing_keys[0].id] : []
}
