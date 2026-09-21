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

- RHEL 9
- Ubuntu 24.04

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

See details: https://docs.rke2.io/install/quickstart

Enable rke2 service (server node)

    $ sudo systemctl enable rke2-server.service
    $ sudo systemctl start rke2-server.service

Install kubeconfig

    $ mkdir ~/.kube
    $ sudo cat /etc/rancher/rke2/rke2.yaml > ~/.kube/config
