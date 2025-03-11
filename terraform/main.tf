data "digitalocean_project" "name" {
  count = var.enabled_do ? 1 : 0
  name  = var.project_name
}

resource "digitalocean_project_resources" "proj" {
  count     = var.enabled_do ? 1 : 0
  project   = data.digitalocean_project.name[0].id
  resources = var.enabled_do && length(var.droplet_configs) == 0 ? [digitalocean_droplet.bot[0].urn] : [for droplet in digitalocean_droplet.bots : droplet.urn]

}

resource "digitalocean_droplet" "bot" {
  count      = var.enabled_do && length(var.droplet_configs) == 0 ? 1 : 0
  vpc_uuid   = local.vpc_uuid
  name       = local.droplet_name
  region     = var.region
  size       = var.droplet_size
  image      = var.image
  ipv6       = var.enable_ipv6
  monitoring = var.enable_monitoring
  ssh_keys   = local.ssh_key_id
  tags       = local.tags

  user_data = templatefile("${path.module}/cloud-init.yaml.tftpl", {
    ssh_key = file(var.solarbx_ssh_key_path)
  })
}

resource "digitalocean_droplet" "bots" {
  for_each   = var.enabled_do ? var.droplet_configs : {}
  vpc_uuid   = local.vpc_uuid
  name       = "${var.droplet_name}-${each.key}"
  region     = each.value.region
  size       = each.value.size
  image      = each.value.image
  ipv6       = var.enable_ipv6
  monitoring = var.enable_monitoring
  ssh_keys   = local.ssh_key_id
  tags       = local.tags

  user_data = templatefile("${path.module}/cloud-init.yaml.tftpl", {
    ssh_key = file(var.solarbx_ssh_key_path)
  })
}

resource "digitalocean_firewall" "firewall" {
  count = var.create_firewall
  name  = var.firewall_name

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = var.firewall_port_22
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "all"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "all"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  tags = local.tags
}
