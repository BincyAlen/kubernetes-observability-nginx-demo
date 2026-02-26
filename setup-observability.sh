#!/bin/bash
# ------------------------------------------------------------
# Prometheus + Grafana Observability Setup for Minikube (M1/M2 Mac)
# Author: Bincy
# ------------------------------------------------------------
 
echo " Checking if Helm is installed..."
if ! command -v helm &> /dev/null; then
  echo "Helm not found. Installing via Homebrew..."
  brew install helm
else
  echo "Helm is already installed."
fi
 
echo "Adding Helm repositories..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
 
echo " Creating monitoring namespace..."
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -
 
echo "Installing Prometheus..."
helm install prometheus prometheus-community/prometheus -n monitoring
 
echo "Installing Grafana (admin/admin)..."
helm install grafana grafana/grafana -n monitoring --set adminPassword=admin
 
echo "Waiting for pods to start..."
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=grafana -n monitoring --timeout=120s
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=prometheus -n monitoring --timeout=120s
 
echo "Opening Grafana Dashboard..."
minikube service grafana -n monitoring
