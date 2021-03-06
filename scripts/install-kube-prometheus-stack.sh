#!/usr/bin/env bash

set -eoux pipefail

minikube delete
minikube start --driver=virtualbox

kubectl create namespace kube-prometheus-stack

# https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack
helm install kube-prometheus-stack ./kube-prometheus-stack \
  --namespace=kube-prometheus-stack \
  --set-string namespaceOverride=kube-prometheus-stack

# kubectl port-forward --namespace=kube-prometheus-stack service/kube-prometheus-stack-grafana 3000:80
# http://127.0.0.1:3000/
# user: admin
# pass: prom-operator

# kubectl port-forward --namespace=kube-prometheus-stack service/kube-prometheus-stack-prometheus 9090:9090
# http://127.0.0.1:9090/
