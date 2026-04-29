# ht-condor-ansible

Ansible playbook to deploy an HTCondor cluster with monitoring on Ubuntu 24.04.

## What it does

- Installs HTCondor 24.0 on all nodes
- Configures one master node (COLLECTOR, NEGOTIATOR, SCHEDD) and N worker nodes (STARTD)
- Installs Prometheus and Grafana on the master
- Installs node_exporter on all nodes
- Exports HTCondor queue and status metrics to Prometheus via a cron-driven textfile collector

## Cluster layout

```
master   10.172.13.20   central manager, scheduler, monitoring
worker1  10.172.13.21   execute node
worker2  10.172.13.22   execute node
worker3  10.172.13.23   execute node
```

Edit `inventory.ini` to match your hosts.

## Requirements

- Ansible on your local machine
- SSH access to all nodes as `clusteruser` with key at `~/.ssh/id_ed25519`
- Ubuntu 24.04 (noble) on all nodes

## Usage

Run the full playbook:

```bash
ansible-playbook -i inventory.ini htcplaybook.yml --ask-become-pass
```

Reconfigure condor only (skip install):

```bash
make reconfigure
```

Other make targets: `restart-condor`, `status`, `logs`

## Load test

Submit 12 parallel prime-finding jobs to verify the cluster:

```bash
cd loadtests
condor_submit loadtest.sub
condor_watch_q
```

Each job finds primes up to 2,000,000 using trial division, requesting 1 CPU and 512 MB RAM.

## Monitoring

After the playbook runs:

- Prometheus: `http://<master>:9090`
- Grafana: `http://<master>:3000`
- HTCondor web: `http://<master>:8080`

Condor queue and node metrics are scraped every 15 seconds via a custom textfile collector script inspired by https://github.com/dsilos/condor_textfile_collector.
