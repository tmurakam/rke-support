#!/bin/bash

RKE2_VERSION=${RKE2_VERSION:-v1.37.0+rke2r1}
KUBECTL_VERSION=${KUBECTL_VERSION:-1.37.0}

KUBECTL=kubectl-${KUBECTL_VERSION}

if [ ! -d .cache ]; then
    mkdir .cache
fi

if [ ! -x /usr/local/bin/rke2 ]; then
    echo "===> Install rke2"

    # update.rke2.io (the installer's channel server) is not reachable (404), and the
    # installer does not detect that, ending up with version "stable". Resolve the
    # version from GitHub ourselves instead. Set RKE2_VERSION to pin (e.g. v1.37.0+rke2r1).
    if [ -z "${RKE2_VERSION}" ]; then
        RKE2_VERSION=$(curl -sfIL -o /dev/null -w '%{url_effective}' \
            https://github.com/rancher/rke2/releases/latest | sed -e 's|.*/||')
    fi
    case "${RKE2_VERSION}" in
        v*.*+rke2r*) ;;
        *) echo "Failed to determine rke2 version: '${RKE2_VERSION}'" >&2; exit 1 ;;
    esac
    echo "rke2 version: ${RKE2_VERSION}"

    curl -sfL https://get.rke2.io | sudo env INSTALL_RKE2_VERSION="${RKE2_VERSION}" sh -
fi

if [ ! -x /usr/local/bin/kubectl ] || [ ! -x /usr/local/bin/${KUBECTL} ]; then
    echo "===> Install ${KUBECTL}"
    if [ ! -e ${KUBECTL} ]; then
        curl -SL https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl >.cache/${KUBECTL}
    fi
    chmod 755 .cache/${KUBECTL}
    sudo /bin/cp .cache/${KUBECTL} /usr/local/bin/${KUBECTL}
    sudo /bin/rm /usr/local/bin/kubectl >/dev/null 2>&1
    sudo ln -s /usr/local/bin/${KUBECTL} /usr/local/bin/kubectl
fi

if [ ! -e /etc/bash_completion.d/kubectl ]; then
    echo "===> Install kubectl bash completion"
    kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl >/dev/null
fi
