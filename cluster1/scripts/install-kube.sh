#!/bin/sh
set -e
echo "==================== running install-kube.sh ===================="

# if kubeadm,kubectl aand kubelet have different version specify here
#K8S_VERSION=1.18.2-00
K8S_VERSION=1.30
#KUBEADM_VERSION=1.18.2-00

# Source: http://kubernetes.io/docs/getting-started-guides/kubeadm/

apt-get remove -y docker.io kubelet kubeadm kubectl kubernetes-cni || true
apt-get autoremove -y || true
systemctl daemon-reload 
# curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
# cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
# deb http://apt.kubernetes.io/ kubernetes-xenial main
# EOF

# cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
# overlay
# br_netfilter
# EOF

# sudo modprobe overlay
# sudo modprobe br_netfilter


apt-get update -y
apt-get upgrade -y

#https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

apt-get install -y apt-transport-https ca-certificates curl gpg

mkdir -p /etc/apt/keyrings

curl -fsSL https://pkgs.k8s.io/core:/stable:/v$K8S_VERSION/deb/Release.key |  gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v$K8S_VERSION/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

apt-get update -y
apt-get install -y kubelet kubeadm kubectl 
apt-mark hold kubelet kubeadm kubectl 

systemctl enable --now kubelet

#apt-get install -y docker.io kubelet=${K8S_VERSION} kubeadm=${K8S_VERSION} kubectl=${K8S_VERSION} kubernetes-cni

systemctl enable kubelet && systemctl start kubelet

# cat > /etc/docker/daemon.json <<EOF
# {
#   "exec-opts": ["native.cgroupdriver=systemd"],
#   "log-driver": "json-file",
#   "storage-driver": "overlay2"
# }
# EOF

# mkdir -p /etc/systemd/system/docker.service.d

# Restart docker.
# systemctl daemon-reload
# systemctl enable docker && systemctl start docker
# usermod -aG docker vagrant
# # hack don't need to reboot or logout
# chmod 777 /var/run/docker.sock
# # systemctl restart docker

# docker info | grep overlay
# docker info | grep systemd


# https://devopscube.com/setup-kubernetes-cluster-kubeadm/

cat <<EOF | tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

modprobe overlay
 modprobe br_netfilter

# sysctl params required by setup, params persist across reboots
cat <<EOF | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sysctl --system

swapoff -a
(crontab -l 2>/dev/null; echo "@reboot /sbin/swapoff -a") | crontab - || true


# Step 3: Install CRI-O Runtime On All The Nodes

apt-get update -y
apt-get install -y software-properties-common curl apt-transport-https ca-certificates

sudo curl -fsSL https://pkgs.k8s.io/addons:/cri-o:/prerelease:/main/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/cri-o-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/cri-o-apt-keyring.gpg] https://pkgs.k8s.io/addons:/cri-o:/prerelease:/main/deb/ /" |
    tee /etc/apt/sources.list.d/cri-o.list

apt-get update -y
apt-get install -y cri-o

systemctl daemon-reload
systemctl enable crio --now
systemctl start crio.service

chmod 777 /var/run/crio/crio.sock
crictl version
crictl ps  # chekc docker iamges

VERSION="v1.30.0"
wget https://github.com/kubernetes-sigs/cri-tools/releases/download/$VERSION/crictl-$VERSION-linux-amd64.tar.gz
 tar zxvf crictl-$VERSION-linux-amd64.tar.gz -C /usr/local/bin
rm -f crictl-$VERSION-linux-amd64.tar.gz



exit 0
