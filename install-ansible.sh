#!/bin/bash

source /etc/os-release

if [ -e /etc/redhat-release ]; then
    if [ "$VERSION_ID" == "7" ]; then
        sudo yum install -y python3 python3-pip python3-libselinux
    else
        sudo yum install -y python38 python38-pip
    fi
else
    sudo apt -y install python3 python3-venv python3-selinux
fi

VENV_DIR=${VENV_DIR:-~/.venv/default}
echo "VENV_DIR = ${VENV_DIR}"
if [ ! -e ${VENV_DIR} ]; then
    python3 -m venv ${VENV_DIR}
fi

source ${VENV_DIR}/bin/activate

pip install -U pip
pip install -r requirements.txt
