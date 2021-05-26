#!/usr/bin/env bash

set -eoux pipefail

minikube delete
minikube start --driver=virtualbox
