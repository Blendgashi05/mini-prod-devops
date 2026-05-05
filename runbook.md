# Runbook - Blue/Green Deployment

## Overview
Ky projekt përdor Blue/Green deployment në Kubernetes për të bërë switch pa downtime.

---

## 1. Kontrollo statusin

bash kubectl get pods -n mini-prod kubectl get svc -n mini-prod 

Të gjitha pods duhet të jenë Running/Ready.

---

## 2. Testo aplikacionin

bash curl http://$(minikube ip):30080/ 

Output:
- Hello from blue
ose
- Hello from green

---

## 3. Switch në GREEN

bash ./scripts/switch-green.sh 

Verifiko:

bash curl http://$(minikube ip):30080/ 

Duhet:
Hello from green

---

## 4. Switch në BLUE

bash ./scripts/switch-blue.sh 

---

## 5. Rollback (nëse ka problem)

bash ./scripts/rollback-blue.sh 

---

## 6. Troubleshooting

Nëse diçka nuk funksionon:

bash kubectl get pods -n mini-prod kubectl describe pod <pod-name> -n mini-prod kubectl logs <pod-name> -n mini-prod 

---

## Expected Behavior

- Aplikacioni nuk bie gjatë switch
- Trafiku kalon nga Blue → Green
- Rollback funksionon menjëherë
