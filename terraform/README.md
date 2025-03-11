# Terraform Configuration for DigitalOcean and Vultr

This Terraform project is designed to deploy and manage infrastructure on **DigitalOcean** and **Vultr**.

## 📌 Requirements

- Terraform >= 1.0
- DigitalOcean API Token
- Vultr API Token (if using Vultr)

## 📜 How to Generate API Keys

### 🔹 DigitalOcean API Token

To create a **DigitalOcean API Token**, follow these steps:

1. Go to [DigitalOcean Control Panel](https://cloud.digitalocean.com/)
2. Navigate to **API** (from the left menu).
3. Under **Personal Access Tokens**, click **Generate New Token**.
4. Provide a name (e.g., `Terraform`).
5. Enable **Read & Write** permissions.
6. Click **Generate Token**.
7. Copy and save the token securely.

### 🔹 Vultr API Key

To create a **Vultr API Key**, follow these steps:

1. Log in to [Vultr Dashboard](https://my.vultr.com/)
2. Click on **Account** > **API**.
3. Enable **API Access** (if not already enabled).
4. Click **Regenerate API Key** (if needed).
5. Copy and save the API key securely.

## 📦 Providers

This project uses the following Terraform providers:

- [DigitalOcean Provider](https://registry.terraform.io/providers/digitalocean/digitalocean/latest)
- [Vultr Provider](https://registry.terraform.io/providers/vultr/vultr/latest)

## 📜 Variables

Below is a list of the main variables used in this Terraform configuration:

| Variable | Description | Default |
|----------|-------------|---------|
| `do_token` | DigitalOcean API Token | Required |
| `vultr_token` | Vultr API Token | Required |
| `region` | DigitalOcean region | `nyc1` |
| `droplet_size` | Size of the Droplet | `s-1vcpu-1gb` |
| `droplet_name` | Name of the Droplet | `bot-sol-1vcpu-1gb-nyc1` |
| `vpc_name` | Name of the VPC | `my-vpc` |
| `droplet_count` | Number of Droplets | `01` |
| `droplet_configs` | Custom Droplet configurations for multi-node deployment | `hcl droplet_configs = { "bot-1" = { region = "nyc1" image = "ubuntu-22-04-x64" size = "s-1vcpu-512mb-10gb" } "bot-2" = { region = "nyc1" image = "ubuntu-22-04-x64" size = "s-1vcpu-512mb-10gb" } "bot-3" = { region = "nyc1" image = "ubuntu-22-04-x64" size = "s-1vcpu-512mb-10gb" } } ` |
| `firewall_name` | Firewall name | `fname` |
| `image` | OS image for the Droplet | `ubuntu-24-04-x64` |
| `enable_ipv6` | Enable IPv6 | `true` |
| `enable_monitoring` | Enable DigitalOcean Monitoring | `true` |
| `firewall_port_22` | Allowed IPs for SSH (port 22) | `["0.0.0.0/0", "::/0"]` |
| `vpc_ip_rang` | VPC IP range | `10.0.0.0/16` |
| `existing_ssh_key_name` | Existing SSH key name in DigitalOcean | Required |
| `solarbx_ssh_key_path` | Path to the SSH public key | `~/.ssh/solarbx.pub` |
| `project_name` | Project name | `""` |
| `create_firewall` | Enable firewall creation (1 = Yes, 0 = No) | `0` |
| `enabled_vultr` | Enable Vultr provisioning | `false` |
| `enabled_do` | Enable DigitalOcean provisioning | `true` |
| `enabled_vultr_multiple_ip` | Enable Vultr Multiple IPV4 | `false` |
| `count_vultr_multiple_ip` | Enable count of Vultr IPv4 maximum is 3 | `false` |

### 🟦 DigitalOcean Example (`vars/digitalocean.tfvars`)

```hcl
do_token = ""


droplet_configs = {
  "bot-1" : {
    region = "nyc1"
    image  = "ubuntu-22-04-x64"
    size   = "s-1vcpu-512mb-10gb"
  }
  "bot-2" : {
    region = "nyc1"
    image  = "ubuntu-22-04-x64"
    size   = "s-1vcpu-512mb-10gb"
  }
  "bot-3" : {
    region = "nyc1"
    image  = "ubuntu-22-04-x64"
    size   = "s-1vcpu-512mb-10gb"
  }
}

droplet_name = "bot-vcpu-512mb-nyc1"

enable_ipv6       = true
enable_monitoring = true
firewall_name     = "allowAll"
droplet_count     = "01"

vpc_name              = "nyc1-vpc"
existing_ssh_key_name = "ssh-key-name"

project_name = "default"
ansible_user = "default"
keypair  = ""

```

### 🟦 vultr Example (`vars/vultr.tfvars`)

```hcl
vultr_token               = "xxxxx"
region                    = "nyc1"
droplet_size              = "vc2-1c-0.5gb"
droplet_name              = "s-1vcpu-1gb-nyc1"
image                     = "2079"
enable_ipv6               = true
enable_monitoring         = true
firewall_name             = "uuid"
droplet_count             = "05"
vpc_name                  = "uuid"
existing_ssh_key_name     = "ssh-key"
project_name              = "default"
enabled_vultr             = true
enabled_do                = false
enabled_vultr_multiple_ip = true
count_vultr_multiple_ip   = 3
```

## 🚀 Usage

1. **Initialize Terraform**

```sh
terraform init
```

### 🔹 Using Terraform with Workspaces

This project uses Terraform Workspaces to manage different environments. Follow these steps to apply Terraform with a specific workspace:

```sh
#! /bin/bash
export WORKSPACE=solarbx
echo $WORKSPACE
terraform workspace select $WORKSPACE || terraform workspace new $WORKSPACE
terraform apply -var-file="./vars/$WORKSPACE.tfvars"
unset WORKSPACE
```