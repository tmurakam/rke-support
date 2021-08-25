#!/bin/bash

VENV_DIR=${VENV_DIR:-~/.venv/default}

if [ ! -d "$VENV_DIR" ]; then
    python3 -m venv $VENV_DIR || exit 1
    pip install -U pip
fi

source $VENV_DIR/bin/activate
