# EKS Production Project

Deployed the Pastefy application on AWS EKS to learn production-grade DevOps practices. Got tired of tutorial projects and wanted to build something real that actually works in production.

## What I Built

A complete Kubernetes platform on AWS that runs a real application with proper monitoring, security, and CI/CD. Took way longer than expected but learned a ton about production DevOps.

### Infrastructure
- **EKS Cluster**: 3-node cluster with auto-scaling
- **VPC Setup**: Public/private subnets across multiple AZs
- **Security**: Proper IAM roles, security groups, SSL certificates
- **Terraform**: Modular infrastructure as code

### Application Stack
- **Pastefy**: Full-stack paste sharing app (Vue.js + Java backend)
- **Database**: MariaDB running in Kubernetes
- **Monitoring**: Prometheus + Grafana dashboards
- **GitOps**: ArgoCD for automated deployments

### DevOps Pipeline
- **CI/CD**: GitHub Actions with security scanning
- **Container Registry**: AWS ECR for Docker images
- **HTTPS**: Let's Encrypt certificates with automatic renewal
- **DNS**: Route53 for custom domain management

## Architecture

![Infrastructure Architecture](screenshots/Infrustructure-architecture-diagram.png)

The setup uses a standard production architecture with users accessing the Pastefy application through Route53 DNS, Application Load Balancer, and into the EKS cluster. The GitOps flow runs from GitHub through CI/CD to ECR and then to EKS for deployments.

## Repository Structure

![Project Structure](screenshots/Directory-structure.png)

The project is organized with clear separation between infrastructure code, Kubernetes manifests, application source, and CI/CD pipelines. Terraform modules provide reusable infrastructure components while k8s-manifests contain all the Kubernetes deployment configurations.

## Live Demo

The platform runs at:
- **Application**: https://pastefy.integratepro.online
- **Monitoring**: https://grafana.integratepro.online
- **Metrics**: https://prometheus.integratepro.online
- **GitOps**: https://argocd.integratepro.online

*Note: Infrastructure is currently destroyed to save costs, but screenshots show the working system.*

## Key Features

**Security First**
- All traffic encrypted with SSL/TLS
- Network isolation with private subnets
- IAM least-privilege access
- Container image vulnerability scanning

**Production Ready**
- High availability across multiple AZs
- Auto-scaling based on demand
- Persistent storage for stateful services
- Comprehensive monitoring and alerting

**GitOps Workflow**
- Infrastructure changes via Terraform
- Application deployments via ArgoCD
- Automated testing and security scanning
- Complete audit trail in Git

![ArgoCD GitOps Dashboard](screenshots/argocd-dashboard.png)

## Deployment

### Prerequisites
- AWS CLI configured with appropriate permissions
- Terraform >= 1.0
- kubectl installed
- Docker for local testing

### Infrastructure Setup

1. **Backend Setup** (one-time)
```bash
cd terraform/backend-setup
terraform init
terraform apply
```

2. **Deploy Infrastructure**
```bash
cd terraform/environments/dev
terraform init
terraform apply
```

3. **Configure kubectl**
```bash
aws eks update-kubeconfig --name eks-production-dev-cluster --region eu-west-2
```

4. **Deploy Applications**
```bash
kubectl apply -f k8s-manifests/
```

### CI/CD Pipeline

![GitHub Actions Pipeline](screenshots/github-actions-pipelines.png)

The GitHub Actions workflow automatically:
- Validates Terraform configurations
- Scans for security vulnerabilities
- Builds and pushes Docker images to ECR
- Updates Kubernetes manifests
- Triggers ArgoCD deployments

## Monitoring

![Grafana Dashboard](screenshots/grafana-dashboard.png)

Prometheus collects metrics from:
- Kubernetes cluster components
- Application performance data
- Infrastructure health metrics

Grafana provides dashboards for:
- CPU and memory usage
- Application response times
- Cluster health overview
- Custom business metrics

![Prometheus Interface](screenshots/prometheus-interface.png)

## Lessons Learned

**What Worked Well**
- Terraform modules made infrastructure reusable
- ArgoCD simplified deployment management
- Prometheus/Grafana combo is solid for monitoring
- Let's Encrypt automation saved tons of time

**What Was Challenging**
- Getting persistent storage right took several attempts
- ArgoCD sync issues when manifests didn't match reality
- SSL certificate management across multiple services
- Debugging networking issues in Kubernetes

**Would Do Differently**
- Start with simpler monitoring setup first
- Use Helm charts for complex applications
- Implement proper secrets management from day one
- Set up log aggregation earlier in the process

## Cost Management

Running this setup costs approximately:
- EKS Cluster: ~$70/month
- EC2 instances: ~$45/month
- Load Balancer: ~$18/month
- Storage: ~$5/month

**Total**: ~$140/month for a production-grade platform

Infrastructure is destroyed when not actively developing to keep costs down.

## Screenshots

The screenshots throughout this README show the actual working system, including the infrastructure architecture, GitOps workflow, monitoring dashboards, and CI/CD pipeline in action.

## Next Steps

If I were to continue this project:

1. **Enhanced Security**
   - Implement Pod Security Standards
   - Add network policies
   - Set up vulnerability scanning automation

2. **Improved Observability**
   - Add distributed tracing
   - Implement log aggregation
   - Set up alerting rules

3. **Production Hardening**
   - Multi-region deployment
   - Disaster recovery procedures
   - Automated backup strategies

## Acknowledgments

Built using:
- [Pastefy](https://github.com/interaapps/pastefy) - The application being deployed
- AWS EKS documentation and examples
- Terraform AWS provider documentation
- Various blog posts and tutorials from the DevOps community

---

This project demonstrates practical experience with modern DevOps tools and practices. The focus was on building something that actually works in production rather than just following tutorials.