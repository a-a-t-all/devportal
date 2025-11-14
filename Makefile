# Makefile at repo root
K3D_CLUSTER ?= devportal
K3D_AGENTS ?= 2


.PHONY: k3d-create k3d-delete kubectx
k3d-create:
	k3d cluster create $(K3D_CLUSTER) --agents $(K3D_AGENTS) --wait


k3d-delete:
	k3d cluster delete $(K3D_CLUSTER)


kubectx:
	kubectl config use-context k3d-$(K3D_CLUSTER)


.PHONY: argocd-install argocd-password
argocd-install:
	kubectl create ns argocd || true
	helm repo add argo https://argoproj.github.io/argo-helm
	helm repo update
	helm upgrade --install argocd argo/argo-cd -n argocd --values platform/values/argocd-values.yaml --wait


argocd-password:
	@echo "Argo CD admin password:" && kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d; echo


.PHONY: apps-bootstrap
apps-bootstrap:
	kubectl apply -n argocd -f platform/apps/appproject-platform.yaml
	kubectl apply -n argocd -f platform/apps/root-app-of-apps.yaml


.PHONY: portforwards
portforwards:
	# Argo CD
	kubectl -n argocd port-forward svc/argocd-server 8080:80 &
	# Grafana (namespace set by kube-prometheus-stack values below)
	kubectl -n observability port-forward svc/kube-prometheus-stack-grafana 3000:80 &