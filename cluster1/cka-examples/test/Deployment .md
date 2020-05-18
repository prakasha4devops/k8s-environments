6. Deployment - Rolling Updates and Rollbacks

i) Create the namespace

kubectl create namespace production

ii) Create the deployment with three replicas

kubectl run nginx-app --image=nginx:1.11.9-alpine --replicas=3 --namespace=production --restart=Always --record

iii) Update the image:

kubectl -n production set image deployment/nginx-app nginx-app=nginx:1.12.0-alpine --record

iv) Rollback the update:

kubectl rollout undo deployment -n production nginx-app --to-revision=1
