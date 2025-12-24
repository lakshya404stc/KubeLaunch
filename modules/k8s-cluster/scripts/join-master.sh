#!/bin/bash
set -e

FIRST_MASTER_IP="${first_master_ip}"

echo "=========================================="
echo "Joining as Kubernetes Master Node"
echo "=========================================="

# Join the cluster
echo "Joining the cluster as control plane..."
chmod +x /tmp/join-command-master.sh
sudo bash /tmp/join-command-master.sh

# Configure kubectl
mkdir -p $HOME/.kube
sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "=========================================="
echo "Successfully joined as master node!"
echo "=========================================="