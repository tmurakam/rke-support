#!/bin/bash

source /etc/os-release

PYTHON=python3.11
if [ -e /etc/redhat-release ]; then
    sudo yum install -y python3.11 python3.11-pip
else
    if [ "$VERSION_ID" == "24.04" ]; then
        PYTHON=python3.12
        sudo apt -y install python3.12 python3.12-venv python3-pip
    else
        sudo apt -y install python3.11 python3.11-venv python3-pip
    fi
fi

VENV_DIR=${VENV_DIR:-~/.venv/default}
echo "VENV_DIR = ${VENV_DIR}"
if [ ! -e ${VENV_DIR} ]; then
    $PYTHON -m venv ${VENV_DIR}
fi

source ${VENV_DIR}/bin/activate

pip install -U pip
pip install -r requirements.txt
