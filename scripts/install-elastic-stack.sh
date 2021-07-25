#!/usr/bin/env bash

set -eoux pipefail

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# minikube start --driver=virtualbox --cpus=3 --memory=5000
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

helm install filebeat ./filebeat \
  --namespace=elastic-stack \
  --values=filebeat-values.yaml

set +x

printf "\n"
echo "kubectl port-forward --namespace=elastic-stack svc/elasticsearch-master 9200"
echo "Access: http://localhost:9200"

printf "\n"
echo "kubectl port-forward --namespace=elastic-stack svc/kibana-kibana 5601"
echo "Access: http://localhost:5601"

printf "\n"
