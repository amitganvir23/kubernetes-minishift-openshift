## Check all nodes
kubectl get nodes

## Check the lables of all nodes
kubectl get nodes --show-labels

## To check labes and other details to the specific node
kubectl describe node node1.example.com

## Enter your cluster node and add a labe name like "test=value". We can use default labels also. like "kubernetes.io/hostname=node1.example.com"
kubectl label nodes node1.example.com test=node1.example.com

## To apply/create deploy container and service
kubectl apply -f hello-app-deploy.yml -n ganesh-test

## To jump in container
kubectl -n ganesh-test exec -it hello2-fdf9df769-ntrjq bash

## To delete all changes from the cluster like deploy container and service
kubectl -n ganesh-test delete -f hello-app-deploy.yml
