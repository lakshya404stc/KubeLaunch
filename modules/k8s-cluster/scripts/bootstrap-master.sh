#!/bin/bash
set -e

KUBERNETES_VERSION="${kubernetes_version}"
CNI_PLUGIN="${cni_plugin}"
POD_SUBNET="${pod_subnet}"

echo "=========================================="
echo "Bootstrapping Kubernetes Master Node"
echo "=========================================="

# Initialize the cluster
echo "Initializing Kubernetes cluster..."
sudo /usr/bin/kubeadm init --config=/tmp/kubeadm-config.yaml --upload-certs

# Configure kubectl for ubuntu user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install CNI plugin
echo "Installing CNI plugin: $CNI_PLUGIN..."
if [ "$CNI_PLUGIN" == "calico" ]; then
  kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/calico.yaml
elif [ "$CNI_PLUGIN" == "flannel" ]; then
  kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
elif [ "$CNI_PLUGIN" == "weave" ]; then
  kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
fi

# Generate join commands
echo "Generating join commands..."
sudo kubeadm token create --print-join-command > /tmp/join-command-worker.sh

sudo kubeadm init phase upload-certs --upload-certs 2>&1 | grep -A 1 "Using certificate key:" | tail -1 > /tmp/certificate-key.txt
CERT_KEY=$(cat /tmp/certificate-key.txt | tr -d '[:space:]')

JOIN_CMD=$(cat /tmp/join-command-worker.sh)
echo "$JOIN_CMD --control-plane --certificate-key $CERT_KEY" > /tmp/join-command-master.sh

chmod 644 /tmp/join-command-*.sh

echo "=========================================="
echo "Master node bootstrap completed!"
echo "=========================================="
