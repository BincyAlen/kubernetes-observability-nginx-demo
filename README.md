# Kubernetes Observability Demo (Nginx + Prometheus + Grafana)

This project demonstrates a Kubernetes-based web application deployed locally using Minikube and monitored through Prometheus and Grafana.

---

##Overview

- Application: Nginx web server  
- Cluster: Local Minikube (on macOS M1)  
- Monitoring Stack: Prometheus + Grafana (installed via Helm)  
- Infrastructure-as-Code: Kubernetes YAML manifests

---

##Steps to Reproduce

## 1. Prerequisites
- Docker Desktop (running)
- Minikube
- Kubectl
- Helm
- macOS / Linux shell

## 2. Start Minikube
```bash
minikube start --driver=docker
```

## 3. Deploy Nginx
```bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl get all
```

## 4. Access Nginx
```bash
minikube service nginx-demo-service
```

---

Observability Setup (Prometheus + Grafana)

Run the setup script:
```bash
./setup-observability.sh
```

It will:
- Install Helm (if missing)
- Deploy Prometheus + Grafana in `monitoring` namespace
- Open Grafana dashboard automatically  
  → login: **admin / admin**

---

##Observability View

##Grafana Dashboards:
- Cluster Overview
- Pod Health
- Container CPU/Memory Utilization

##Prometheus Metrics:
- Node Exporter (node stats)
- Kube-State-Metrics (Kubernetes objects)

---

##Cleanup

To remove all observability components:
```bash
./cleanup-observability.sh
minikube stop
```

---

##Key Learnings

- Deployed workloads using Kubernetes YAML manifests.
- Exposed services via NodePort for local access.
- Integrated Prometheus and Grafana for real-time monitoring.
- Understood exporters (Node Exporter, Kube-State-Metrics) for cluster insights.
- Observed pod-level metrics and node health visually.

