#!/bin/bash

RKE_VERSION=${RKE_VERSION:-1.3.11}
KUBECTL_VERSION=${KUBECTL_VERSION:-1.23.6}

RKE=rke-${RKE_VERSION}
KUBECTL=kubectl-${KUBECTL_VERSION}

if [ ! -d .cache ]; then
    mkdir .cache
fi

if [ ! -x /usr/local/bin/rke ] || [ ! -x /usr/local/bin/${RKE} ]; then
    echo "===> Install ${RKE}"
    if [ ! -e ${RKE} ]; then
        curl -SL https://github.com/rancher/rke/releases/download/v${RKE_VERSION}/rke_linux-amd64 >.cache/${RKE}
    fi
    chmod 755 .cache/${RKE}
    sudo cp .cache/${RKE} /usr/local/bin/${RKE}
    sudo /bin/rm /usr/local/bin/rke >/dev/null 2>&1
    sudo ln -s /usr/local/bin/${RKE} /usr/local/bin/rke
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
