#!/bin/bash
kubectl patch svc mini-app-service -n mini-prod \
  -p '{"spec":{"selector":{"app":"mini-app","version":"green"}}}'

echo "Switched traffic to GREEN"
curl http://$(minikube ip):30080/
