# EKS Production Project

A production-grade Kubernetes platform deployed on AWS EKS, demonstrating enterprise DevOps practices with infrastructure as code, GitOps automation, and comprehensive monitoring. This project implements a fully automated, scalable platform hosting the Pastefy application with real-world production features including SSL termination, monitoring, and CI/CD workflows.

## Overview

This project sets up a cloud-native paste sharing application on a production-grade Kubernetes cluster running on Amazon Elastic Kubernetes Service (EKS). It uses Terraform to handle the entire infrastructure on AWS, and GitHub Actions powers a reliable CI/CD pipeline. An Amazon Elastic Container Registry (ECR) is created for managing Docker images, and the NGINX Ingress Controller manages global traffic securely and efficiently—including HTTPS support. The setup is designed for scalability, security, and smooth performance. It includes Cert-Manager for automatic SSL certificates, ExternalDNS for real-time DNS updates, ArgoCD for GitOps-based deployment, and Prometheus & Grafana for full-stack monitoring and visibility.

## End-to-End Architecture Diagram

![Infrastructure Architecture](screenshots/Infrustructure-architecture-diagram.png)

## 🌐 Live Demonstration

**Production Environment:**
- **Application**: https://eks.integratepro.online
- **Monitoring**: https://grafana.integratepro.online  
- **Metrics**: https://prometheus.integratepro.online
- **GitOps**: https://argocd.integratepro.online

*Note: Infrastructure is deployed on-demand to optimize operational costs.*

## Key Components

| Component | Description |
|-----------|-------------|
| **Amazon EKS** | Hosts the production-grade Kubernetes cluster that runs the Pastefy application |
| **Amazon ECR** | Stores and manages Docker images securely, used by the EKS cluster for application deployments |
| **GitHub Actions (CI/CD)** | Automates testing, building, security scanning, and deployment of infrastructure and application code |
| **Terraform** | Manages and provisions all infrastructure components using Infrastructure as Code (IaC) practices |
| **ArgoCD** | Implements GitOps to continuously synchronize Kubernetes manifests from the Git repository to EKS |
| **NGINX Ingress Controller** | Manages HTTP/HTTPS traffic routing inside the cluster and supports SSL termination |
| **Cert-Manager** | Automatically issues and renews SSL certificates using Let's Encrypt for secure HTTPS access |
| **ExternalDNS** | Updates Route53 DNS records dynamically based on Kubernetes Ingress resources |
| **Prometheus** | Collects and stores metrics for the cluster, application, and infrastructure monitoring |
| **Grafana** | Visualizes metrics from Prometheus and provides dashboards for real-time observability |
| **Trivy** | Performs container image vulnerability scanning as part of the CI workflow |
| **Checkov** | Scans Terraform code for misconfigurations and compliance issues in infrastructure definitions |

## Project Structure

![Project Structure](screenshots/Directory-structure.png)

The codebase maintains clear separation between infrastructure definitions, Kubernetes manifests, application source code, and CI/CD configurations. Terraform modules provide reusable infrastructure components while k8s-manifests contain deployment specifications.

## Deployment to AWS

This project automates the deployment of the Pastefy application to AWS using a modern GitOps-driven workflow built on EKS, Terraform, and GitHub Actions. The deployment process includes the following stages:

### 1. Dockerization
The application is containerized using the Dockerfile located in the `app/` directory. This ensures consistency across development, staging, and production environments.

### 2. Building and Pushing the Docker Image
When code changes are pushed to the main branch, the GitHub Actions workflow is triggered. It builds the Docker image, runs security vulnerability scans, and pushes the image to Amazon ECR.

### 3. Infrastructure Validation
GitHub Actions workflows execute:
- `terraform plan` to preview infrastructure changes
- Security scanning with Checkov for compliance issues
- YAML validation for Kubernetes manifests

### 4. Infrastructure Provisioning
Once approved and merged, Terraform provisions or updates infrastructure on AWS, including ECR, EKS, networking, and DNS components.

### 5. GitOps Deployment via ArgoCD
ArgoCD continuously watches the Git repository (under `k8s-manifests/`) and automatically syncs Kubernetes manifests to the EKS cluster. This ensures that the live environment always reflects the desired state stored in Git.

### 6. Ingress, SSL, and DNS Setup
- **NGINX Ingress Controller** handles HTTPS routing within the EKS cluster
- **Cert-Manager** automatically issues and renews SSL certificates via Let's Encrypt
- **ExternalDNS** syncs Kubernetes ingress records with Route53, enabling real-time domain mapping

### 7. Monitoring and Observability
Prometheus collects metrics from the cluster and workloads. Grafana dashboards provide real-time insights into application and infrastructure health.

## 📸 Pastefy App: Live on AWS with GitOps, Monitoring, and CI/CD

### ✅ ArgoCD: GitOps Deployment to EKS
Pastefy is continuously deployed to EKS using ArgoCD. All Kubernetes manifests are stored in Git (`k8s-manifests/`), and ArgoCD keeps the EKS cluster in sync with the Git source of truth.

![ArgoCD GitOps Dashboard](screenshots/argocd-dashboard.png)

### ✅ Prometheus & Grafana: Full-Stack Observability
Prometheus scrapes metrics from the EKS cluster, workloads, and system components. Grafana provides real-time dashboards and alerting for system health, resource usage, and application performance.

**Prometheus Interface:**
![Prometheus Interface](screenshots/prometheus-interface.png)

**Grafana Monitoring Dashboard:**
![Grafana Dashboard](screenshots/grafana-dashboard.png)

### ✅ CI/CD Pipeline via GitHub Actions
Every change to the codebase or infrastructure triggers GitHub Actions workflows that run Docker builds, security scans, Terraform validation, and apply changes automatically upon merge.

![GitHub Actions Pipeline](screenshots/github-actions-pipelines.png)

### ✅ Route53 DNS Configuration
The Pastefy application and monitoring tools are publicly accessible via custom subdomains managed in Route53.

DNS records are automatically configured to point to the AWS Load Balancer endpoints for the following services:
- `eks.integratepro.online` → Pastefy application
- `grafana.integratepro.online` → Grafana dashboards  
- `prometheus.integratepro.online` → Prometheus monitoring UI
- `argocd.integratepro.online` → ArgoCD GitOps interface

This setup enables:
- Clean, branded, and user-friendly URLs
- Real-time DNS resolution via ExternalDNS
- Secure HTTPS access via certificates provisioned by Cert-Manager

## Prerequisites

- AWS CLI configured with appropriate IAM permissions
- Terraform >= 1.0 installed
- kubectl command-line tool
- Docker for container operations

## Quick Start

### 1. Backend Setup (one-time)
```bash
cd terraform/backend-setup
terraform init
terraform apply
```

### 2. Deploy Infrastructure
```bash
cd terraform/environments/dev
terraform init
terraform apply
```

### 3. Configure kubectl
```bash
aws eks update-kubeconfig --name eks-production-dev-cluster --region eu-west-2
```

### 4. Deploy Applications
```bash
kubectl apply -f k8s-manifests/
```

## Cost Analysis

**Monthly operational costs (approximate):**
- EKS Control Plane: ~$70
- Worker Node Instances: ~$45  
- Application Load Balancer: ~$18
- Persistent Storage: ~$5
- **Total: ~$140/month**

Infrastructure is provisioned on-demand for development to optimize operational expenses.

## Technology Stack

Built leveraging:
- **Pastefy** - Open source paste sharing application
- **AWS EKS** - Managed Kubernetes service
- **Terraform** - Infrastructure as code
- **ArgoCD** - GitOps continuous delivery
- **Prometheus/Grafana** - Monitoring and observability
- **NGINX Ingress** - Traffic routing and SSL termination
- **Cert-Manager** - Automated certificate management

---

This project demonstrates practical implementation of modern DevOps methodologies and cloud-native technologies in a production-ready environment.