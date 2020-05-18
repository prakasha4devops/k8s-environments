# Kubernetes K8S  Environments


## setup and run
You will start a 3 node cluster on your machine, one master and 2 worker. For this you need to install VirtualBox and vagrant, then:


```
git clone git@github.com:prakasha4devops/k8s-environments.git
cd k8s-environments/cluster1
./up.sh

vagrant ssh cluster1-master-1

vagrant@cluster1-master-1:~$kubectl version
vagrant@cluster1-master-1:~$kubectl get node
vagrant@cluster1-master-1:~$kubectl get pods
vagrant@cluster1-master-1:~#kubectl cluster-info


assign role label to worker
kubectl label node cluster1-worker-1 node-role.kubernetes.io/worker=worker
kubectl label node cluster1-worker-2 node-role.kubernetes.io/worker=worker

## example folder
=============
cd /vagrant/cka-examples


few examples to run
------------
kubectl run  busybox --image=busybox:1.28 --command -- sleep 3600

kubectl get pods -l run=busybox


kubectl exec -ti busybox -- nslookup kubernetes





```
