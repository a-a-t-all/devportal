DevPortal Platform — Local Developer Platform with GitOps, Observability & Policy Control

This project is to build a fully automated, Internal Developer Platform (IDP) to practice infrastructure as code, GitOps workflows, Kubernetes automation, and developer experience tooling.

1) GitOps with Argo CD

All platform components are deployed using Argo CD and the GitOps model.
Push to Git → Argo automatically reconciles the cluster.

2) Observability Stack

Prometheus-> Metrics collection
Grafana-> Dashboards and visualization
Loki-> Centralized log storage
Promtail-> Log agent shipping Kubernetes pod logs to Loki
Tempo->	Distributed tracing backend
OpenTelemetry-> Collector Gateway for metrics/traces/logs

3) Policy Enforcement (Gatekeeper)

OPA Gatekeeper enforces Kubernetes policies (even though some CRDs remain OutOfSync by design).

4) Ingress Controller

Nginx Ingress provides internal routing for services like Grafana and Backstage.

5) Backstage Developer Portal

A local DevPortal providing:

Catalog with components

Future plugins (Grafana, Argo CD, Kubernetes, TechDocs)

Foundation for scaffolder templates

UI entry point for developers

6) Local Development Workflow
to create the cluster :
make k3d-create
make kubectx

to install Argo CD :
make argocd-install
make argocd-password

to bootstrap Platform Apps :
make apps-bootstrap

to Forward local ports (ArgoCD UI + Grafana):
make portforwards

7) Accessing the Platform
Service	URL	Notes
Argo CD	http://localhost:8080

Grafana	http://localhost:3100

Backstage	http://localhost:3000
 (your Vite port may vary)	Developer portal

8) Backstage Setup

A Backstage app lives under:

backstage/devportal-backstage/


You can run it locally:

yarn install
yarn dev


A sample Backstage catalog entry is included:

backstage/catalog-info.yaml

9) License:

MIT
