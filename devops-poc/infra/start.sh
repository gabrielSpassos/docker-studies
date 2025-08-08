#!/bin/sh

echo "\nStarting infra and services..."

minikube start --driver=docker

kubectl config use-context minikube

tofu init

tofu apply -auto-approve

echo "\nWaiting for services to be ready..."
sleep 20

kubectl config view --minify --flatten > /tmp/kubeconfig-jenkins
kubectl delete secret jenkins-kubeconfig -n devops-poc-infra-namespace || true
kubectl create secret generic jenkins-kubeconfig --from-file=config=/tmp/kubeconfig-jenkins -n devops-poc-infra-namespace

nohup kubectl port-forward svc/prometheus-server 30001:80 \
  -n devops-poc-infra-namespace --address 0.0.0.0 > prometheus.log 2>&1 &

nohup kubectl port-forward svc/grafana 30002:80 \
  -n devops-poc-infra-namespace --address 0.0.0.0 > grafana.log 2>&1 &

nohup kubectl port-forward svc/jenkins 30003:80 \
  -n devops-poc-infra-namespace --address 0.0.0.0 > jenkins.log 2>&1 &

nohup kubectl port-forward svc/flask-poc-app 30004:80 \
  -n devops-poc-application-namespace --address 0.0.0.0 > app.log 2>&1 &
