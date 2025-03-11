terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    vultr = {
      source  = "vultr/vultr"
      version = "2.23.1"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

provider "vultr" {
  api_key     = var.vultr_token
  rate_limit  = 100
  retry_limit = 3
}
