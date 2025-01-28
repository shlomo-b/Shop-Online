# Project Shop Online

Overview

Project Shop Online is a cloud-native e-commerce platform deployed on AWS using Kubernetes, Terraform, and ArgoCD. It leverages GitOps principles for continuous deployment and integrates with GitHub Actions for CI/CD automation.

Architecture

Technologies Used:

Cloud Provider: AWS (EKS, RDS, S3, Route 53, ALB, WAF)

Container Orchestration: Kubernetes

Infrastructure as Code: Terraform

GitOps: ArgoCD

CI/CD Pipeline: GitHub Actions

Monitoring: Prometheus, Grafana

Security: AWS WAF, IAM roles, External Secrets

Authentication: Azure Active Directory (SSO)

System Components:

Frontend: React-based UI deployed in Kubernetes.

Backend: Node.js/Express API for handling business logic.

Database: AWS RDS (PostgreSQL or MySQL).

Networking: ALB routes traffic to Kubernetes services.

Monitoring: Prometheus and Grafana for observability.

Deployment

Prerequisites

AWS account with necessary IAM permissions.

Terraform installed (>=1.5.6).

Kubernetes CLI (kubectl) installed.

ArgoCD CLI installed.

GitHub repository access for CI/CD.

Steps

Clone Repository

git clone https://github.com/your-repo/shop-online.git
cd shop-online

Terraform Infrastructure Setup

cd main-infra
terraform init
terraform apply

Deploy ArgoCD and Applications

kubectl apply -f argo-cd/argocd-install.yaml
kubectl apply -f app-of-apps/root-application.yaml

Monitor Deployment

kubectl get pods -n shop-online

CI/CD Pipeline

GitHub Actions Workflow automates deployments:

terraform.yml: Runs Terraform to provision infrastructure.

backend-shop.yml: Builds and deploys backend.

react-frontend-shop.yml: Builds and deploys frontend.

ArgoCD syncs Kubernetes manifests from GitHub.

Monitoring & Security

Prometheus & Grafana provide real-time monitoring.

AWS WAF protects against web threats.

External Secrets securely fetches credentials.

![presentation](docs/presentation.png)
