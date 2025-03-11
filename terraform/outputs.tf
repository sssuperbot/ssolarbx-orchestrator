output "vpc_uuid" {
  value = local.vpc_uuid
}

output "ipv4_address" {
  value = length(var.droplet_configs) > 0 ? "" : try(digitalocean_droplet.bot[0].ipv4_address, vultr_instance.my_instance[0].main_ip)
}

output "ipv6_address" {
  value = length(var.droplet_configs) > 0 ? "" : try(digitalocean_droplet.bot[0].ipv6_address, vultr_instance.my_instance[0].v6_main_ip)
}

output "droplet_name" {
  value = local.droplet_name
}

output "vultr_multi_ip" {
  value = try(join(",", [for ip in vultr_reserved_ip.my_instance_ipv4 : ip.subnet]), "")
}

output "droplet_ips" {
  description = "Map of droplet IP addresses (IPv4 and IPv6)"
  value = {
    for key, droplet in digitalocean_droplet.bots : key => {
      ip_addresses = {
        v4 = droplet.ipv4_address
        v6 = droplet.ipv6_address
      }
    }
  }
}
