#!/bin/bash

cd $(dirname $0)

if [ $# -eq 0 ]; then
    echo "usage: $0 [addresses..]"
    exit 1
fi

export NETWORK_PLUGIN=${NETWORK_PLUGIN:-canal}

num_nodes=$#
nodes="$*"

if [ -z "$NUM_ETCD" ]; then
    NUM_ETCD=1
    if [ "$num_nodes" -ge 3 ]; then
        NUM_ETCD=3
    fi
fi

if [ -z "$NUM_CONTROL" ]; then
    NUM_CONTROL=1
    if [ "$num_nodes" -ge 2 ]; then
        NUM_CONTROL=2
    fi
    if [ "$num_nodes" -ge 3 ]; then
        NUM_CONTROL=3
    fi
fi

if [ -z "$NUM_WORKER" ]; then
    NUM_WORKER=$(($num_nodes - 3))
    if [ "$num_nodes" -le 3 ]; then
        NUM_WORKER=1
    fi
fi
worker_offset=$(($num_nodes - $NUM_WORKER))

echo "# nodes: $num_nodes"
echo "# control plane: $NUM_CONTROL"
echo "# etcd: $NUM_ETCD"
echo "# worker: $NUM_WORKER"

echo "nodes:"
idx=0
for node in $nodes; do
    cat <<EOF
- address: "$node"
  port: "22"
  internal_address: ""
  role:
EOF

    if [ "$idx" -lt "$NUM_CONTROL" ]; then
        echo "  - controlplane"
    fi
    if [ "$idx" -lt "$NUM_ETCD" ]; then
        echo "  - etcd"
    fi
    if [ "$idx" -ge "$worker_offset" ]; then
        echo "  - worker"
    fi

    cat <<EOF    
  hostname_override: ""
  user: ubuntu
  docker_socket: /var/run/docker.sock
  ssh_key: ""
  ssh_key_path: ~/.ssh/id_rsa
  ssh_cert: ""
  ssh_cert_path: ""
  labels: {}
  taints: []
EOF
    idx=$((idx + 1))
done

envsubst <./cluster-common.yml
