#!/bin/sh
set -e

echo "==================== running install-worker.sh ===================="
kubeadm reset -f
sh /vagrant/tmp/master-join-command.sh
systemctl daemon-reload
service kubelet start