#!/bin/bash

if [ -e /etc/redhat-release ]; then
    sudo yum install -y python3 python3-pip python3-libselinux
else
    sudo apt -y install python3 python3-venv python3-selinux
fi

VENV_DIR=${VENV_DIR:-~/.venv/default}
echo "VENV_DIR = ${VENV_DIR}"
if [ ! -e ${VENV_DIR} ]; then
    python3 -m venv ${VENV_DIR}
fi

pip install -U pip
pip install -r requirements.txt
