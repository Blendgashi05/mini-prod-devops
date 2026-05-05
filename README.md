
# 🚀 Mini Prod DevOps Project (Step-by-Step)

---

## 🔧 1. Docker (Local Dev)

docker-compose build  
docker-compose up -d  

Test:
curl http://localhost:5000/health  

---

## 🏗️ 2. Terraform (Generate Config)

cd terraform  
terraform init  
terraform apply -auto-approve  

Test version:
terraform apply -var="app_version=v2"  

Kontrollo:
cat ../generated/k8s-values.json  
cat ../generated/inventory.ini  

---

## ⚙️ 3. Ansible (Setup Environment)

ansible-playbook -i ../generated/inventory.ini ansible/site.yml  

---

## ☸️ 4. Kubernetes Deploy

kubectl apply -f k8s/namespace.yaml  
kubectl apply -f k8s/postgres.yaml  
kubectl apply -f k8s/app-blue.yaml  
kubectl apply -f k8s/app-green.yaml  
kubectl apply -f k8s/service.yaml  

Kontrollo:
kubectl get pods -n mini-prod  
kubectl get svc -n mini-prod  

---

## 🌐 5. Test Application (Minikube)

curl http://$(minikube ip):30080/health  

---

## 🔄 6. Blue / Green Switching

Switch në GREEN:
./scripts/ci/switch.sh  

(ose nëse i ke manual):
./scripts/switch-green.sh  

Switch në BLUE:
./scripts/switch-blue.sh  

---

## 🔙 7. Rollback

./scripts/rollback-blue.sh  

---

## 🤖 8. Jenkins Pipeline (AUTOMATIC)

Pipeline bën automatikisht:

./scripts/ci/test.sh  
./scripts/ci/build.sh  
./scripts/ci/terraform.sh  
./scripts/ci/ansible.sh  
./scripts/ci/deploy.sh  
./scripts/ci/smoke.sh  
./scripts/ci/switch.sh  

---

## 🧪 9. Smoke Test

./scripts/ci/smoke.sh  

ose manual:
curl http://127.0.0.1:5000/health  

---

## 🔁 10. Full Flow

Pipeline rrjedh kështu:

GitHub → Jenkins → Test → Build → Terraform → Ansible → Deploy → Smoke → Switch  

---

## 📊 11. Monitoring (Prometheus / Grafana)

Prometheus përdoret për metrika, ndërsa Grafana për vizualizim.

Hap Prometheus:
http://localhost:9090

Hap Grafana:
http://localhost:3000

Në Grafana:
- Add data source → Prometheus
- URL: http://prometheus:9090
- Save & Test

---

## 🔁 12. Rollback Demo / Failure Simulation

Për të simuluar problem në Green:

```bash
docker stop mini-app-local
## 📂 Struktura

mini-prod/
├── app/
├── ansible/
├── terraform/
├── k8s/
├── scripts/
│   └── ci/
├── generated/
├── Jenkinsfile
└── README.md

---

## ✅ Expected Output

Hello from blue  
Hello from green  

---

## 🎯 Status

✔ Docker OK  
✔ Terraform OK  
✔ Ansible OK  
✔ Kubernetes OK  
✔ Jenkins Pipeline OK  
✔ Blue-Green OK  
✔ Rollback OK  

---
