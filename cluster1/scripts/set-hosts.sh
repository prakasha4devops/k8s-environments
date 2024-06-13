#!/bin/bash
set -e
echo "=============== running set-hosts.sh ==============="

#IFNAME=$1
#ADDRESS="$(ip -4 addr show $IFNAME | grep "inet" | head -1 |awk '{print $2}' | cut -d/ -f1)"
#sed -e "s/^.*${HOSTNAME}.*/${ADDRESS} ${HOSTNAME} ${HOSTNAME}.local/" -i /etc/hosts
#
## remove ubuntu-bionic entry
#sed -e '/^.*ubuntu-bionic.*/d' -i /etc/hosts

# Update /etc/hosts about other hosts
cat >> /etc/hosts <<EOF
192.168.101.101  cluster1-master-1
192.168.101.201  cluster1-worker-1
192.168.101.202  cluster1-worker-2
EOF

