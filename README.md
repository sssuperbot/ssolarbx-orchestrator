# solarbx-orchestrator

A high-performance arbitrage bot for Solana, designed to execute efficient and profitable trades across decentralized exchanges (DEXs).

## How to run

> docker-compose run --rm ansible

## 1. create new or upgrade bot version

```
# apply all host
ansible-playbook  playbooks/upgrade.yml

# apply some host
ansible-playbook  playbooks/upgrade.yml --limit <name-host>
```

## 2. update only config

```
# apply all host
ansible-playbook  playbooks/update-config.yml

# apply some host
ansible-playbook  playbooks/update-config.yml --limit <name-host>
```
