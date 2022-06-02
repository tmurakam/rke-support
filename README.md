# Rancher Kubernetes Engine (RKE) support scripts

# What is this?

RKE1 support ansible playbook and scripts.

Run this ansible playbook before use rke tool.

- Disable SELinux
- Disable firewalld
- Disable swap
- Configure netfilter
- Install docker CE

## Requirements

- RHEL7 / CentOS 7
- RHEL8 / AlmaLinux 8
- Ubuntu 20.04

# Installation

## Install ansible

Install python3 and ansible.

    $ ./install-ansible.sh

## Run ansible to setup nodes

Activate python venv including ansible.

    $ ~/.venv/default/bin/activate

Run ansible playbook

    $ cd playbook
    $ vi hosts   # edit inventory file
    $ ansible-playbook -i hosts site.yml

## Install RKE binary

    $ ./install-cli.sh

## Setup RKE cluster

Create RKE cluster config (cluster.yml)

    $ rke config

Deploy RKE cluster

    $ rke up

Install kubeconfig

    $ mkdir ~/.kube
    $ cp kube_config_cluster.yml ~/.kube/config
