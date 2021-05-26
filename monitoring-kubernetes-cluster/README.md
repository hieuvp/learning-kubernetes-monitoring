# Monitoring K8s with the Kubernetes Dashboard, Prometheus, and Grafana

[https://cloudacademy.com/lab/monitoring-kubernetes-cluster/](https://cloudacademy.com/lab/monitoring-kubernetes-cluster/)

## Table of Contents

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Deploy a Simple API Application](#deploy-a-simple-api-application)
- [Install and Configure K8s Dashboard](#install-and-configure-k8s-dashboard)
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

## Install and Configure K8s Dashboard

## Install and Configure Prometheus

## Install and Configure Grafana
