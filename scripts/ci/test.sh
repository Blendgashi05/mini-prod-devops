
#!/bin/bash
set -e

echo "Testing local docker-compose app..."

eval $(minikube docker-env -u)

docker-compose up -d --build

sleep 10

curl http://127.0.0.1:5000/health
curl http://127.0.0.1:5000/
