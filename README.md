# Rancher Kubernetes Engine (RKE) support scripts

# What is this?

## Requirements

- RHEL7 / CentOS 7
- RHEL8 / AlmaLinux 8
- Ubuntu 20.04

# Installation

## Install ansible

Install python3 ansible.

    $ ./install-ansible.sh

## Run ansible to setup nodes

Activate python venv including ansible.

    $ ~/.venv/default/bin/activate

Run ansible playbook

    $ cd playbook
    $ vi hosts   # edit inventory file
    $ ansible-playbook -i hosts site.yml

This will install Docker CE, disable, swap, etc on all nodes.

## Install RKE binary

    $ ./installcli.sh

## Setup RKE cluster

Create RKE cluster config (cluster.yml)

    $ rke config

Deploy RKE cluster

    $ rke up

Install kubeconfig

    $ mkdir ~/.kube
    $ cp kube_config_cluster.yml ~/.kube/config
