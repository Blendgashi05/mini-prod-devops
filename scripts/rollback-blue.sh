#!/bin/bash
kubectl patch svc mini-app-service -n mini-prod \
  -p '{"spec":{"selector":{"app":"mini-app","version":"blue"}}}'

echo "Rollback completed: traffic returned to BLUE"
curl http://$(minikube ip):30080/
