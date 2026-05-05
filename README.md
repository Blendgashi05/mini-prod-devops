# Mini-Prod DevOps Project

## 1. Docker (Local Dev)

docker-compose build  
docker-compose up -d  

Test:
curl http://localhost:5000/health  


## 2. Terraform (Config Artifacts)

cd terraform  
terraform init  
terraform apply  

Ndrysho version:
terraform apply -var="app_version=v2"  

Shiko files:
cat ../generated/k8s-values.json  
cat ../generated/inventory.ini  


## 3. Ansible (Setup Environment)

ansible-playbook -i ../generated/inventory.ini ansible/site.yml  


## 4. Kubernetes Deploy

kubectl apply -f k8s/namespace.yaml  
kubectl apply -f k8s/postgres.yaml  
kubectl apply -f k8s/app-blue.yaml  
kubectl apply -f k8s/app-green.yaml  
kubectl apply -f k8s/service.yaml  

Kontrollo:
kubectl get pods -n mini-prod  
kubectl get svc -n mini-prod  


## 5. Test Application

curl http://$(minikube ip):30080/  


## 6. Blue / Green Switching

Switch në GREEN:
./scripts/switch-green.sh  

Switch në BLUE:
./scripts/switch-blue.sh  


## 7. Rollback

./scripts/rollback-blue.sh  


## Expected Output

Hello from blue  
Hello from green
