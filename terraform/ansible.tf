resource "local_file" "ansible_inventory" {
  content  = <<-EOT
[bot_servers]
%{for idx, bot in keys(digitalocean_droplet.bots)~}
solarbx-${var.droplet_name}-${bot} ansible_host=${values(digitalocean_droplet.bots)[idx].ipv4_address}
ansible_user=${var.ansible_user}
%{endfor~}
  EOT
  filename = "../${path.module}/inventory/hosts.${var.droplet_name}"
}

resource "local_file" "config_yaml" {
  for_each = digitalocean_droplet.bots

  content = <<-EOT
    keypair: "${lookup(var.droplet_configs[each.key], "keypair", "")}"
    bind_ips:
      - "${each.value.ipv4_address}"
      - "${each.value.ipv6_address}"
    jito_bind_ips:
      - "${each.value.ipv4_address}"
%{if try(var.droplet_configs[each.key].bot_version, null) != null}
    bot_version: "${try(var.droplet_configs[each.key].bot_version, "")}"
%{endif}
%{if try(var.droplet_configs[each.key].swap_threads, null) != null}
    swap_threads: "${try(var.droplet_configs[each.key].swap_threads, 0)}"
%{endif}
%{if try(var.droplet_configs[each.key].mint, null) != null}
    mint: "${try(var.droplet_configs[each.key].mint, "")}"
%{endif}
%{if try(var.droplet_configs[each.key].mint_decimal, null) != null}
    mint_decimal: ${try(var.droplet_configs[each.key].mint_decimal, 0)}
%{endif}
%{if try(var.droplet_configs[each.key].jupiter_url, null) != null}
    jupiter_url: "${try(var.droplet_configs[each.key].jupiter_url, "")}"
%{endif}
%{if try(var.droplet_configs[each.key].jupiter_api_key, null) != null}
    jupiter_api_key: "${try(var.droplet_configs[each.key].jupiter_api_key, "")}"
%{endif}
%{if try(var.droplet_configs[each.key].min_spend, null) != null}
    min_spend: ${try(var.droplet_configs[each.key].min_spend, 0)}
%{endif}
%{if try(var.droplet_configs[each.key].max_spend, null) != null}
    max_spend: ${try(var.droplet_configs[each.key].max_spend, 0)}
%{endif}
%{if try(var.droplet_configs[each.key].jupiter_delay, null) != null}
    jupiter_delay: ${try(var.droplet_configs[each.key].jupiter_delay, 0)}
%{endif}
%{if try(var.droplet_configs[each.key].jito_static_tip_lamports, null) != null}
    jito_static_tip_lamports: ${try(var.droplet_configs[each.key].jito_static_tip_lamports, 0)}
%{endif}
%{if try(var.droplet_configs[each.key].jito_static_tip_percent, null) != null}
    jito_static_tip_percent: ${try(var.droplet_configs[each.key].jito_static_tip_percent, 0)}
%{endif}
%{if try(var.droplet_configs[each.key].auto_max_spend, null) != null}
    auto_max_spend: ${try(var.droplet_configs[each.key].auto_max_spend, false)}
%{endif}
%{if try(var.droplet_configs[each.key].cu_limit_per_route, null) != null}
    cu_limit_per_route: ${try(var.droplet_configs[each.key].cu_limit_per_route, 0)}
%{endif}

%{if try(var.droplet_configs[each.key].proxy_wallet, false) != null}
    proxy_wallet: ${try(var.droplet_configs[each.key].proxy_wallet, false)}
%{endif}

%{if try(var.droplet_configs[each.key].transfer_proxy_lamports, 0) != null}
    transfer_proxy_lamports: ${try(var.droplet_configs[each.key].transfer_proxy_lamports, 0)}
%{endif}

%{if try(var.droplet_configs[each.key].proxy_cu_limit, 0) != null}
    proxy_cu_limit: ${try(var.droplet_configs[each.key].proxy_cu_limit, 0)}
%{endif}

%{if try(var.droplet_configs[each.key].min_gain, false) != null}
    min_gain: ${try(var.droplet_configs[each.key].min_gain, 0)}
%{endif}
%{if try(var.droplet_configs[each.key].static_mints_enabled, null) != null}
    static_mints_enabled: ${try(var.droplet_configs[each.key].static_mints_enabled, false)}
%{endif}
%{if try(length(var.droplet_configs[each.key].static_mints), 0) > 0}
    static_mints:
%{for mint in try(var.droplet_configs[each.key].static_mints, [])}
      - "${mint}"
%{endfor}
%{endif}
%{if try(length(var.droplet_configs[each.key].jito_configs), 0) > 0}
    jito_configs:
%{for cfg in try(var.droplet_configs[each.key].jito_configs, [])}
      - enabled: ${try(cfg.enabled, false)}
        url: "${try(cfg.url, "")}"
%{endfor}
%{endif}
  EOT

  filename = "../${path.module}/inventory/host_vars/solarbx-${var.droplet_name}-${each.key}.yml"
}
