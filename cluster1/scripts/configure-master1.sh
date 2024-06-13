#!/bin/sh
set -e
echo "==================== running configure-master1.sh ===================="
cp /vagrant/scripts/resources/kube-scheduler-amazing.yaml /etc/kubernetes/manifests/
#
#source <(kubectl completion bash) # setup autocomplete in bash into the current shell, bash-completion package should be installed first.
echo "source <(kubectl completion bash)" >> /home/vagrant/.bashrc # add autocomplete permanently to your bash shell.
#
## https://kubernetes.io/docs/reference/kubectl/cheatsheet/#kubectl-autocomplete
#
alias k=kubectl
#complete -F __start_kubectl k

cat > /home/vagrant/.vimrc <<EOF
set nu
set ic
set expandtab
set shiftwidth=2
set tabstop=2
EOF

echo "alias k=kubectl" >> /home/vagrant/.bashrc