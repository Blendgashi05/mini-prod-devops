#!/bin/bash
set -e

echo "Rolling back to BLUE..."
kubectl patch svc mini-app-service -n mini-prod --type=merge -p '{"spec":{"selector":{"app":"mini-app","version":"blue"}}}'
echo "Traffic switched to BLUE"
