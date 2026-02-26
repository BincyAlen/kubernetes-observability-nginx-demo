#!/bin/bash
# ------------------------------------------------------------
# Cleanup Script - Removes Prometheus + Grafana from Minikube
# Author: Bincy
# ------------------------------------------------------------

echo "🧹 Cleaning up Prometheus and Grafana installations..."

# Check if namespace exists
if kubectl get ns monitoring &> /dev/null; then
  echo "🚮 Uninstalling Prometheus and Grafana..."
  helm uninstall prometheus -n monitoring 2>/dev/null || echo "Prometheus not found."
  helm uninstall grafana -n monitoring 2>/dev/null || echo "Grafana not found."

  echo "🗑️  Deleting monitoring namespace..."
  kubectl delete namespace monitoring --ignore-not-found=true

  echo "🧾 Cleaning Helm cache..."
  helm repo remove prometheus-community 2>/dev/null
  helm repo remove grafana 2>/dev/null
  helm repo update

  echo "✅ Cleanup complete!"
else
  echo "⚠️  Monitoring namespace not found — nothing to clean."
fi

echo "🛑 (Optional) You can now stop Minikube to free resources:"
echo "    minikube stop"