# Monitoring K8s with the Kubernetes Dashboard, Prometheus, and Grafana

> [https://cloudacademy.com/lab/monitoring-kubernetes-cluster/](https://cloudacademy.com/lab/monitoring-kubernetes-cluster/)

## Table of Contents

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Deploy a Simple API Application](#deploy-a-simple-api-application)
- [Install and Configure K8S Dashboard](#install-and-configure-k8s-dashboard)
- [Install and Configure Prometheus](#install-and-configure-prometheus)
- [Install and Configure Grafana](#install-and-configure-grafana)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Deploy a Simple API Application

Deploy the API application.
In the terminal execute the following command:

```shell
kubectl apply -f ./code/k8s
```

In order to generate traffic against the deployed API - spin up a single generator pod.
In the terminal execute the following command:

```shell
kubectl run generator --env="API_URL=http://api-service:5000" --image=cloudacademydevops/api-generator --image-pull-policy IfNotPresent
```

## Install and Configure K8S Dashboard

Create a new monitoring namespace within the cluster.
In the terminal execute the following command:

```shell
kubectl create ns monitoring
```

Using Helm, install the Kubernetes Dashboard using the publicly available Kubernetes Dashboard Helm Chart.
Deploy the dashboard into the monitoring namespace within the lab provided cluster.
In the terminal execute the following commands:

```shell
{
helm repo add k8s-dashboard https://kubernetes.github.io/dashboard
helm repo update
helm install k8s-dashboard --namespace monitoring k8s-dashboard/kubernetes-dashboard --set=protocolHttp=true --set=serviceAccount.create=true --set=serviceAccount.name=k8sdash-serviceaccount --version 3.0.2
}
```

Establish permissions within the cluster to allow the Kubernetes Dashboard to read and write all cluster resources.
In the terminal execute the following command:

```shell
kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=monitoring:k8sdash-serviceaccount
```

The Kubernetes Dashboard web interface now needs to be exposed to the Internet so that you can browse to it.
To do so, create a new NodePort based Service, and expose the web admin interface on port 30990.
In the terminal execute the following command:

```shell
{
kubectl expose deployment k8s-dashboard-kubernetes-dashboard --type=NodePort --name=k8s-dashboard --port=30990 --target-port=9090 -n monitoring
kubectl patch service k8s-dashboard -n monitoring -p '{"spec":{"ports":[{"nodePort": 30990, "port": 30990, "protocol": "TCP", "targetPort": 9090}]}}'
}
```

## Install and Configure Prometheus

Using Helm, install Prometheus using the publicly available Prometheus Helm Chart.
Deploy Prometheus into the monitoring namespace within the lab provided cluster.
In the terminal execute the following commands:

```shell
{
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://charts.helm.sh/stable
helm repo update
helm install prometheus --namespace monitoring --values ./code/prometheus/values.yml prometheus-community/prometheus --version 13.0.0
}
```

Patch the Prometheus Node Exporter DaemonSet to ensure that Prometheus can collect Memory and CPU node metrics.
In the terminal execute the following command:

```shell
kubectl patch daemonset prometheus-node-exporter -n monitoring -p '{"spec":{"template":{"metadata":{"annotations":{"prometheus.io/scrape": "true"}}}}}'
```

The Prometheus web admin interface now needs to be exposed to the Internet so that you can browse to it.
To do so, create a new NodePort based Service, and expose the web admin interface on port 30900.
In the terminal execute the following command:

```shell
{
kubectl expose deployment prometheus-server --type=NodePort --name=prometheus-main --port=30900 --target-port=9090 -n monitoring
kubectl patch service prometheus-main -n monitoring -p '{"spec":{"ports":[{"nodePort": 30900, "port": 30900, "protocol": "TCP", "targetPort": 9090}]}}'
}
```

## Install and Configure Grafana
