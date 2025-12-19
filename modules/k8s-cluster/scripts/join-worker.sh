#!/bin/bash
set -e

FIRST_MASTER_IP="${first_master_ip}"

echo "=========================================="
echo "Joining as Kubernetes Worker Node"
echo "=========================================="

# Join the cluster
echo "Joining the cluster as worker..."
chmod +x /tmp/join-command-worker.sh
sudo bash /tmp/join-command-worker.sh

echo "=========================================="
echo "Successfully joined as worker node!"
echo "=========================================="