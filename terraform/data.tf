data "digitalocean_ssh_keys" "existing_keys" {
  count = var.enabled_do ? 1 : 0
}
data "digitalocean_vpc" "existing_vpc" {
  count = var.enabled_do ? 1 : 0
  name  = var.vpc_name
}

data "vultr_ssh_key" "existing_keys" {
  count = var.enabled_vultr ? 1 : 0
  filter {
    name   = "name"
    values = [var.existing_ssh_key_name]
  }

}
