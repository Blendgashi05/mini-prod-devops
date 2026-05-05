#!/bin/bash
set -e

echo "Switching traffic to GREEN..."
kubectl patch svc mini-app-service -n mini-prod --type=merge -p '{"spec":{"selector":{"app":"mini-app","version":"green"}}}'
echo "Traffic switched to GREEN"
