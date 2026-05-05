#!/bin/bash
set -e

sleep 5

curl http://$(minikube ip):30080/health
