# project shop-online
# AWS Kubernetes Infrastructure Project

## Overview
This project implements a production-grade Kubernetes infrastructure on AWS, featuring comprehensive CI/CD pipelines, robust security measures, and modern DevOps practices. The infrastructure is fully automated using Terraform and follows GitOps principles with Argo CD.

## Architecture
![presentation](docs/presentation.png)

### Key Components

#### Infrastructure Layer
- **AWS Cloud Infrastructure**
  - Virtual Private Cloud (VPC) with public and private subnets
  - EKS clusters for container orchestration
  - S3 buckets for storage and artifacts
  - Route 53 for DNS management
  - AWS Certificate Manager for SSL/TLS
  - AWS WAF for security and traffic control

#### Application Layer
- **Container Orchestration**
  - Kubernetes (EKS) for container management
  - Helm charts for package management
  - Argo CD for GitOps deployment
  - External Secrets for secure configuration
  - AWS Load Balancer Controller

#### Security Layer
- **Identity and Access Management**
  - Azure Active Directory SSO integration
  - IAM roles and policies
  - External Secrets with ClusterSecretStore
  - AWS Secrets Manager integration

#### Monitoring Stack
- **Observability Tools**
  - Prometheus for metrics collection
  - Grafana for visualization
  - Loki for log aggregation
  - Promtail for log collection

## Features

### CI/CD Pipeline

#### Overview
The project implements separate CI/CD pipelines for frontend and backend components using GitHub Actions. Each pipeline includes security scanning, multi-architecture builds, and automated deployments.

#### Frontend Pipeline
The frontend CI/CD pipeline automates the build and deployment of the React application:

- **Trigger Conditions**:
  - Push to main branch in `shop-online-app/frontend/**`
  - Pull requests affecting frontend code
  
- **Key Features**:
  - Multi-architecture Docker builds (AMD64/ARM64)
  - Automated vulnerability scanning with Trivy
  - Docker Hub integration with versioned tags
  - Conditional builds based on branch and event type

#### Backend Pipeline
The backend CI/CD pipeline handles the Flask application deployment:

- **Trigger Conditions**:
  - Push to main branch in `shop-online-app/backend/**`
  - Pull requests affecting backend code

- **Key Features**:
  - Cross-platform container builds
  - Security scanning integration
  - Automated Docker Hub publishing
  - Unique versioning using GitHub run IDs

#### Security Features

##### Vulnerability Scanning
- Pre-build security assessment with Trivy
- Automated scanning of base images
- Vulnerability reporting and tracking
- Integration with existing security tools

##### Access Control
- Secure Docker Hub authentication
- Repository-level access management
- Secret handling for sensitive data

#### Build Architecture

##### Multi-Platform Support
- Simultaneous AMD64 and ARM64 builds
- QEMU emulation for cross-platform compatibility
- Docker Buildx optimization
- Platform-specific testing and validation

##### Image Management
- Unique tags for each build (`github.run_id`)
- Latest tag synchronization
- Automated cleanup of old images
- Version tracking and rollback capability

### Security Features
- AWS WAF protection
- SSL/TLS certification through ACM
- Secure secret management
- Azure AD SSO integration
- IAM role-based access control

### Kubernetes Integration
- App of Apps pattern with Argo CD
- Helm charts for all components
- AWS Load Balancer Controller integration
- External DNS configuration
- ClusterSecretStore implementation

### Monitoring and Logging
- Real-time metrics with Prometheus
- Visual dashboards in Grafana
- Centralized logging with Loki
- Log forwarding with Promtail

## Prerequisites
- AWS Account with administrative access
- Azure Active Directory tenant
- GitHub account with repository access
- kubectl and helm installed locally
- AWS CLI configured
- Terraform installed locally

## Getting Started
<details><summary>Click to infrastructure deployment</summary>
### Infrastructure Deployment
1. Clone the repository:
   ```bash
   https://github.com/shlomo-b/Shop-Online.git
   cd project-name
   ```

2. Initialize Terraform:
   ```bash
   cd terraform
   terraform init
   ```

3. Deploy the infrastructure:
   ```bash
   terraform plan
   terraform apply
   ```

### Argo CD Setup
1. Install Argo CD:
   ```bash
   helm install prod-argocd argo/argo-cd --namespace argocd --create-namespace --version 7.7.23
   apply the repo
   kubectl apply -f repo.yml
   ```

### Application Deployment argocd and app of apps
1. Apply the App of Apps pattern,the app of app includes applications
   aws load balancer controller,external-dns,external-secrets,keel,metrics-server,promtail:
   ```bash
   kubectl apply -f root-application.yaml
   ```

2. Verify deployments:
   ```bash
   kubectl get applications -n argocd
   ```

3. Verify access to argocd
   ```bash
   kubectl port-forward service/prod-argocd-server -n argocd 8080:443
   ---

4. Apply the secret file: for SSO
   ```bash
   kubectl apply -f secret-sso.yml
   ```

5. Upgrade argocd values.yaml,its for authentication SSO to Azure AD
   You need ACM certificate and domain in Route53
   ```bash   
   helm upgrade prod-argocd argo/argo-cd --namespace argocd -f values.yaml --create-namespace --version 7.7.23
   ```   
## Security Configuration

### Required Configuration

#### GitHub Secrets
- `DOCKERHUB_USERNAME`: Docker Hub account name
- `DOCKERHUB_TOKEN`: Access token for Docker Hub

#### Repository Settings
- Branch protection rules
- Required status checks
- Automated cleanup workflows
- Build trigger configurations

### External Secrets
1. Configure AWS Secrets Manager:
   ```bash
   A service role for AWS Secrets Manager is required. Terraform will create this role, retrieve the secrets from GitHub, and push them to AWS
   ```

2. Configure the ClusterSecretStore:
   ```bash
   kubectl apply -f ClusterSecretStore-application.yml
   ```  
### Application Deployment Shop Online
1. Deploy the application:
   ```bash
   kubectl apply -f root-application.yml
   ``` 
</details>

### SSL/TLS Setup
1. Request certificates in ACM
2. Configure DNS in Route 53
3. Update Load Balancer configuration

## Monitoring Setup

### Prometheus & Grafana
1. Deploy monitoring stack:
   ```bash
   helm upgrade --install monitoring ./helm/monitoring
   ```

2. Access Grafana:
   ```bash
   kubectl port-forward svc/grafana 3000:3000
   ```

### Logging Configuration
1. Deploy Loki and Promtail:
   ```bash
   helm upgrade --install logging ./helm/logging
   ```

2. Verify log collection:
   ```bash
   kubectl logs -n logging deployment/loki
   ```

## CI/CD Benefits
1. **Automated Workflows**
   - Reduced manual intervention
   - Consistent build processes
   - Automated testing and validation

2. **Security Integration**
   - Early vulnerability detection
   - Automated security patches
   - Compliance maintenance

3. **Efficiency Improvements**
   - Parallel build processes
   - Optimized caching
   - Reduced deployment time

4. **Quality Assurance**
   - Consistent build environments
   - Automated testing
   - Version control integration

## Best Practices
1. Regular security updates
2. Periodic workflow maintenance
3. Secret rotation and management
4. Build cache optimization
5. Regular cleanup tasks

## Acknowledgments
- AWS EKS Team
- Argo CD Community
- Kubernetes Community