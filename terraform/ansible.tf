resource "local_file" "ansible_inventory" {
  content  = <<-EOT
[bot_servers]
%{for idx in range(length(digitalocean_droplet.bots))~}
solarbx--${var.droplet_name}-${idx} ansible_host=${values(digitalocean_droplet.bots)[idx].ipv4_address}
ansible_user=${var.ansible_user}
%{endfor~}
  EOT
  filename = "../${path.module}/inventory/hosts.${var.droplet_name}"
}

resource "local_file" "config_yaml" {
  for_each = { for idx, key in keys(digitalocean_droplet.bots) : idx => digitalocean_droplet.bots[key] }

  content = <<-EOT
    keypair: "${var.keypair}"
    swap_threads: ${var.swap_threads}
    bind_ips:
      - "${each.value.ipv4_address}"
      - "${each.value.ipv6_address}"
    jito_bind_ips:
      - "${each.value.ipv4_address}"
  EOT
  filename = "../${path.module}/inventory/host_vars/solarbx-${var.droplet_name}-${each.key}.yml"
}
