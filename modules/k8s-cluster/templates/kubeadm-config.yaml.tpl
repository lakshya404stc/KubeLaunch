apiVersion: kubeadm.k8s.io/v1beta3
kind: ClusterConfiguration
kubernetesVersion: ${kubernetes_version}
controlPlaneEndpoint: "${control_plane_endpoint}:6443"
networking:
  podSubnet: ${pod_subnet}
  serviceSubnet: ${service_subnet}
apiServer:
  certSANs:
  - ${control_plane_endpoint}
  extraArgs:
    authorization-mode: "Node,RBAC"
controllerManager:
  extraArgs:
    bind-address: "0.0.0.0"
scheduler:
  extraArgs:
    bind-address: "0.0.0.0"
etcd:
  local:
    extraArgs:
      listen-metrics-urls: "http://0.0.0.0:2381"
---
apiVersion: kubeadm.k8s.io/v1beta3
kind: InitConfiguration
localAPIEndpoint:
  advertiseAddress: ${control_plane_endpoint}
  bindPort: 6443
---
apiVersion: kubelet.config.k8s.io/v1beta1
kind: KubeletConfiguration
cgroupDriver: systemd