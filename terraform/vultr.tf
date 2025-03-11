resource "vultr_instance" "my_instance" {
  count               = var.enabled_vultr ? 1 : 0
  plan                = var.droplet_size
  region              = "ewr" # New Jersey curl https://api.vultr.com/v2/regions | jq
  os_id               = var.image
  label               = local.droplet_name
  tags                = local.tags
  hostname            = local.droplet_name
  enable_ipv6         = true
  disable_public_ipv4 = false
  backups             = "disabled"
  ddos_protection     = false
  activation_email    = false
  vpc_ids             = [var.vpc_name]
  ssh_key_ids         = local.ssh_key_id_vultr
  firewall_group_id   = var.firewall_name
  user_data = templatefile("${path.module}/cloud-init.yaml.tftpl", {
    ssh_key = file(var.solarbx_ssh_key_path)
  })
}

resource "vultr_reserved_ip" "my_instance_ipv4" {
  count       = var.enabled_vultr && var.enabled_vultr_multiple_ip ? var.count_vultr_multiple_ip : 0
  instance_id = vultr_instance.my_instance[0].id
  ip_type     = "v4"
  region      = var.region
}
