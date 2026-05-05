#!/bin/bash
set -e

echo "Using Minikube Docker..."
eval $(minikube docker-env)

echo "Building Docker image for Kubernetes..."
docker build -t mini-app:latest ./app
