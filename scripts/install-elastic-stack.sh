#!/usr/bin/env bash

set -eoux pipefail

# minikube start --driver=virtualbox

cd elastic-stack

kubectl create namespace elastic-stack

helm install elasticsearch ./elasticsearch \
  --namespace=elastic-stack \
  --values=elasticsearch-values.yaml

helm install kibana ./kibana \
  --namespace=elastic-stack \
  --values=kibana-values.yaml

helm install metricbeat ./metricbeat \
  --namespace=elastic-stack \
  --values=metricbeat-values.yaml
