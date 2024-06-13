#!/bin/sh
set -e
echo "=============== running install-master.sh ==============="


apt-get update -y
apt-get install -y etcd-client unzip



TERRAFORM_VERSION="1.8.5"  # 6/2024
# # ---------- terraform installation --------------

wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin \
  && rm -rf terraform_${TERRAFORM_VERSION}_linux_amd64.zip
 
NODENAME=$(hostname -s)


kubeadm reset -f
#kubeadm init --apiserver-advertise-address=$MASTER_IP --pod-network-cidr=$POD_NW_CIDR
kubeadm init --apiserver-advertise-address=$MASTER_IP  --apiserver-cert-extra-sans=$MASTER_IP  --pod-network-cidr=$POD_NW_CIDR --node-name $NODENAME

kubeadm token create --print-join-command --ttl 0 > /vagrant/tmp/master-join-command.sh

mkdir -p $HOME/.kube
sudo cp -Rf /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
sudo cp $HOME/.kube/config /vagrant/tmp/kubeconfig_admin

cp /vagrant/certs/id_rsa /root/.ssh/id_rsa
cp /vagrant/certs/id_rsa.pub /root/.ssh/id_rsa.pub
chmod 400 /root/.ssh/id_rsa
chmod 400 /root/.ssh/id_rsa.pub

#kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

#Install Calico Network Plugin for Pod Networking  - https://devopscube.com/setup-kubernetes-cluster-kubeadm/
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
