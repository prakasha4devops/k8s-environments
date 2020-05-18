Set the context

rs - replicaset
cm -- configmap
po - pods
sa - servioceaccounts
svc - services
ep - endpoints
deploy -deployment


export ns=default
alias k='kubectl -n $ns' # This helps when namespace in question doesn't have a friendly name 
alias kdr='kubectl -n $ns -o yaml --dry-run'.  # run commands in dry run mode and generate yaml.

kubectl explain ingress --recursive | grep version -A10 (Will display 10 lines)
kubectl explain <object_name>.spec

kubectl config current-context  

source <(kubectl completion bash)

VM settings

vim ~/.vimrc
set nu
set expandtab
set shiftwidth=2
set tabstop=2

:set nu
:set et
:set sw=2 ts=2 sts=2

without cluster info :
kubectl get po nginx -o yaml --export

Secrets :
====================
envFrom:
    - secretRef:
        name: test-secret


env:
    - name: BACKEND_USERNAME
      valueFrom:
        secretKeyRef:
          name: backend-user
          key: backend-username
		  
 volumes:
    - name: secret-volume
      secret:
        secretName: test-secret
		
===================
ConfigMap Ref
===================

kubectl create cm configmap3 --from-env-file=config.env


       - name: LOG_LEVEL
          valueFrom:
            configMapKeyRef:
              name: env-config
              key: log_level
			  
      envFrom:
      - configMapRef:
          name: special-config
		  
     volumeMounts:
      - name: config-volume
        mountPath: /etc/config
  volumes:
    - name: config-volume
      configMap:
        # Provide the name of the ConfigMap containing the files you want
        # to add to the container
        name: special-config
		  
======================

command: [ "sh", "-c"]

create service : 
kubectl run nginx --image=nginx --replicas=2 --port=80 --expose

ShortCuts:
------------------
$ kubectl run nginx --image=nginx   (deployment)
$ kubectl run nginx --image=nginx --restart=Never   (pod)
$ kubectl run busybox --image=busybox --restart=OnFailure   (job)
$ kubectl run busybox --image=busybox --schedule="* * * * *"  --restart=OnFailure (cronJob)

Verifying the Env :
----------------
$ kubectl exec -it nginx /bin/bash
root@nginx:/# env

Set Image :
--------------
kubectl set image deploy/nginx nginx=nginx:1.9.1
kubectl rollout status deploy/nginx
kubectl rollout undo deploy/nginx

Create 
------

kubectl create deployemnt --image=nginx:1.7.8 nginx
kubectl create job pi  --image=perl -- perl -Mbignum=bpi -wle 'print bpi(2000)'
kubectl create job busybox --image=busybox -- /bin/sh -c 'echo hello;sleep 30;echo world'
kubectl create cronjob busybox --image=busybox --schedule="*/1 * * * *" -- /bin/sh -c 'date; echo Hello from the Kubernetes cluster'
kubectl create configmap onfig --from-literal=foo=lala --from-literal=foo2=lolo
kubectl create cm configmap2 --from-file=config.txt
kubectl create cm configmap3 --from-env-file=config.env


kubectl create secret generic mysecret --from-literal=password=mypass

Run
------------
Deployment creation :
kubectl run foo --image=dgkanatsios/simpleapp --labels=app=foo --port=8080 --replicas=3

Pod creation:
kubectl run nginx --image=nginx --restart=Never --serviceaccount=myuser -o yaml --dry-run > pod.yaml
kubectl run nginx --image=nginx --restart=Never --requests='cpu=100m,memory=256Mi' --limits='cpu=200m,memory=512Mi'
kubectl run nginx --image=nginx:latest --generator=run-pod/v1 --limts="cpu=200m,memory=512Mi" --dry-run
kubectl run busybox --image=busybox --dry-run --generator=cronjob/v1beta1 --schedule="*/1 * * * *" -- /bin/sh -c "date; echo hello from kubernetes cluster"

kubectl run buysbox --image=busybox:latest --rm -it --restart=Never
pod "buysbox" created

kubectl run buysbox --image=busybox:latest --rm -it --restart=Never --dry-run -o yaml > busybox.yaml

kubectl run nginx --image=nginx --restart=Never --dry-run -o yaml | kubectl create -n mynamespace -f -

kubectl run busybox --image=busybox --command --restart=Never -it -- env # -it will help in seeing the output
# or, just run it without -it
kubectl run busybox --image=busybox --command --restart=Never -- env
# and then, check its logs
kubectl logs busybox

kubectl create namespace myns -o yaml --dry-run

kubectl get po --all-namespaces

kubectl create quota myrq --hard=cpu=1,memory=1G,pods=2 --dry-run -o yaml


kubectl run nginx --image=nginx --restart=Never --port=80

Update Image command
# kubectl set image POD/POD_NAME CONTAINER_NAME=IMAGE_NAME:TAG
kubectl set image pod/nginx nginx=nginx:1.7.1
kubectl describe po nginx # you will see an event 'Container will be killed and recreated'
kubectl get po nginx -w # watch it

Get Pod image : 

kubectl get po nginx -o jsonpath='{.spec.containers[].image}{"\n"}'

Get this pod's YAML without cluster specific information

kubectl get po nginx -o yaml --export


kubectl explain po.spec

Taint 
===============
kubectl taint node node-name key=value:tainteffect

Toleration :
==============
container level

tolerations:
- key: "key"
  operator: "Equal"
  value: "value"
  effect: "NoSchedule"
  
Nodeaffinity
===================
at container level 

affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: color
            operator: In
            values:
            - blue			
			
affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: node-role.kubernetes.io/master
            operator: Exists
            values:
            - blue
			
==============
Liveness Probe  inside container 

livenessProbe:
      exec:
        command:
        - cat
        - /tmp/healthy
	  initialDelaySeconds: 5
      periodSeconds: 5
		
		or
      httpGet:
        path: /healthz
        port: 8080
		
		or
		
		livenessProbe:                  # add
          tcpSocket:                    # add
            port: 80                    # add
          initialDelaySeconds: 10       # add
          periodSeconds: 15             # add

		
		
=====================
Jobs :

Job Spec leavel

spec:
  template:
  completions:
  backoffLimit: 4
  parallelism:
  
================
Ingress : ing

apiVersion: extensions/v1beta1
kind: Ingress

---- 

k command -h

k run command -i -- command arg

================

rollout deploy

kubectl rollout history deployment nginx1 # show history
kubectl rollout undo deployment nginx1

k exec podname env

// create a pod
kubectl run nginx --image=nginx --restart=Never --port=80
// List the pod with different verbosity
kubectl get po nginx --v=7
kubectl get po nginx --v=8
kubectl get po nginx --v=9

kubectl get po -o=custom-columns="POD_NAME:.metadata.name, POD_STATUS:.status.containerStatuses[].state"

kubectl get pods --sort-by=.metadata.name

kubectl get pods -l 'env in (dev,prod)'

kubectl label pod/nginx-dev3 env=uat --overwrite

kubectl get po -l app=webapp -w

kubectl autoscale deploy webapp --min=5 --max=6 --cpu-percent=80

k get hpa

grep -e string1 -e string2
grepe "str1|str2"

echo -e "foo3=lili\nfoo4=lele" > config.txt
echo -n admin > username

kubectl set resources deployment nginx --limits=cpu=200m,memory=512Mi --requests=cpu=100m,memory=256Mi

kubectl cp busybox:/etc/passwd ./passwd # kubectl cp command


alias k=kubectl
source <(kubectl completion bash) # completion will save a lot of time and avoid typo
source <(kubectl completion bash | sed 's/kubectl/k/g' ) # so completion works with the alias "k"

echo 'foo' | tee foo.txt

vim
:help
:set number

x delete character
dd delete line
dG delete from current pos to till end
u undo line
gg	First line
G	Last line
:n	Go to line n
0 (zero)	Start of line
$	End of line
ctrl+r redo
/word search  - n next N previous
:%s/word/replword replace everything
:%s/word/replword/gc 	for the confirming the replace
d2w - which deletes 2 words .. number can be changed for deleting the number of consecutive words like d3w
type a command :e and press ctrl+D to list all the command name starts with :e and press tab to complete the command

'ZZ' - Save and exit quickly.

shift + v (Select and copy (yy) then p)


kubectl create quota my-quota --hard=cpu=1,memory=1G,pods=2,services=3,replicationcontrollers=2,resourcequotas=1,secrets=5,persistentvolumeclaims=10


Exam tips :
These instructions can also be pulled up during the exam by typing “man lf_exam” in the
command line.


Root privileges can be obtained by running 'sudo -i'

For Windows: Ctrl+Insert to copy and Shift+Insert to paste


Use Ctrl+Alt+W instead of Ctrl+W. Ctrl+W is a keyboard shortcut that will close the
current tab in Google Chrome.


kubectl config use-context k8s
ssh k8s-node-0


kubectl get events | grep -i error


tmux

CTRL+B, (release and then) C — create new shell within existing terminal window
CTRL+B, N — switch between shells
CTRL+B, a digit — switch to the chosen shell by the corresponding number
CTRL+B, " — split current window horizontally into panels (panels are inside windows)
CTRL+B, o — switch between panels in current window
CTRL+B, x — close panel

accessing svc from another namespace : DNS : svcname.nsname:port

sudo iptables-save | grep <<Servicename>>
DNS
cat /etc/resolv.conf

kubectl exec ubuntu-sleeper whoami