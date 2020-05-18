Exam Preparation Practice Test
1. POD Logging

Apply the following manifest to your K8s cluster:

https://github.com/zealvora/myrepo/blob/master/demo-files/cka_logs.yaml

Monitor the logs for all the containers which are part of the counter2 pod. Extract log lines which have the number 02. Write them to /opt/kplabs-foobar



2. Daemonset

Ensure a single instance of Pod nginx is running on each node of the kubernetes cluster where nginx also represents the image name which has to be used. Do not override any taints currently in place. Use Daemon set to complete this task and use kplabs-daemonset as Daemonset's name.



3. Init Container

Create a pod from the busybox image. Add an init container in such a way that it should create a file in the location of /opt/myfile. This file should be accessible from the nginx image as well. The name of pod should be base-pod



4. Multi-Container Pod

Create a pod named kucc4 with a single container for each of the following images running inside (there may be between 1 and 4 images specified): nginx + redis + memcached + consul



5. Node Selectors

Schedule a Pod as follows:

Name: kplabs-selector

Image:nginx

Launch pod on the node which has a disktype of ssd.

Make sure the Pod is in ready state.



6. Deployment - Rolling Updates and Rollbacks



Create a deployment as follows

Name：nginx-app

Namespace: production

Using container nginx with version 1.11.9-alpine

The deployment should contain 3 replicas

Next, deploy the app with new version 1.12.0-alpine by performing a rolling update and record that update.

Finally, rollback that update to the previous version 1.11.9-alpine



7. Service

Create and configure the service front-end-service so it‘s accessible through NodePort/ClusterIP and routes to the existing pod under the nginx-app deployment.



8. PODS and Namespace

Create a Pod as follows:

Name: jenkins

Using image: jenkins

In a new Kubernetes namespce named website-frontend



9. Deployments

Create a deployment spec file that will：



Launch 7 replicas of the redis image with the label:app_env_stage=dev

Deployment name: kua100201

Save a copy of this spec file to /opt/KUAL00201/deploy_spec.yaml

When you are done, clean up (delete) any new k8s API objects that you produced during this task



10. Labels and Selectors

Create a file /opt/KUCC00302/kucc00302.txt that lists all pods in the front-end-service in the production namespace.



11. Secrets

Create a Kubernetes Secret as follows:

Name: super-secret

Data of the secret:

credential=alice  
username=bob
Create a Pod named pod-secrets-via-file using the nginx image which mounts a secret named super-secret at /secrets

Create a second Pod named pod-secrets-via-env using the nginx image, which exports credential and username as SUPERSECRET and USER environment variables.



12. Volumes

Create a pod as following details:

Name：non-persistent-redis

Container image: redis

Name-volume with name: cache-control

Mount path: /data/redis

It should launch in the pre-pod namespace and the volumes must not be persistent.



13. Scaling the Deployment

Scale the nginx-app deployment to 6 pods.



14. Metric Server

From the pods of the default namespace, identify the one which is taking the most CPU. Write the name of the pod to /opt/cpu.txt

Note: For your practice environment, go ahead and install metric server first.



15. DNS

Create a deployment as follows

Name: nginx-dns

Exposed via a service: nginx-dns

Ensure that the service & pod are accessible via their respective DNS records

The container(s) within any pod(s) running as a part of this deployment should use the nginx image

Use the utility nslookup to look up the DNS records of the service & pod and write the output to /opt/service.dns and /opt/pod.dns respectively



16.  Node Draining

Set the first node within your cluster to be unavailable and re-schedule all the pods running on it.



17. Persistent Volumes

Create a persistent volume with name app-config of capacity 1Gi and access mode ReadWriteOnce. The type of volume is hostPath and its location is /opt/pvsort.txt



18 Sorting Operation

Apply the following manifest file within your cluster:

https://github.com/zealvora/myrepo/blob/master/demo-files/pv-sorting.yaml

List all PVs sorted by the capacity and save the full kubectl output to /opt/my_volumes.txt

Use kubectl‘s own functionally for sorting the output and do not manipulate it any further



19. Labels and Selectors

Create a pod with the following specification:

Name: kplabs-jenkins

Image: jenkins

The pod should have a label of env=development and org=kplabs



20. Sorting Operation

List all the PVs sorted by the name and store the output to /opt/pv-sort-name.txt



21. Deployments

Create a deployment with the following specification:

Image: Nginx

Name: kplabs-nginx-deploy

Label:   org=kplabs

Replicas = 2



22. Jobs

Create a job that will write "Hello CKA" in a total of 20 times with 2 parallelisms.



23 POD Security Context

Create a pod named pod-security. The pod should be launched from the busybox image and it should run with the command of ping 127.0.0.1 . The primary process should run with the UID of 1005. The pod should be launched in the namespace of security. Check the logs of the POD and output the log to the file /tmp/pod-security.txt



24. Configuring Kubernetes Cluster

Launch two servers based on Ubuntu 18 image. Configure the Kubernetes cluster with kubeadm. Set 1 server as Master Node and 2nd server as a worker node. This question will be marked as complete once both the nodes's status is Ready.



25.  Taints

List all the nodes which do not contain any non-scheduling and not-reachable node. Write the output to /opt/nodes.txt



26. Static Pods

Create a static pod on the worker node. The name should be kplabs-static and it should be launched from the nginx image.



27. Taints

Add  a taint to one of the worker node  where key is mykey, value is mvalue and effect should be NoSchedule



28 . Toleration

Create a deployment named kplabs-tolerate. The deployment should be launched from nginx image and it should tolerate the taint of mykey:myvalue:Noschedule. Create 6 replicas of the deployment.

