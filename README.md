# 🏗️ k3d-idp-demo-argocd-v2-infra

This repository contains the automated **Infraestructure as Code (IaC)** blueprints provisioned by **Backstage IDP** to orchestrate core platform components inside your local **K3d cluster** using **Terraform and Helm**.

---

## 📋 Infrastructure Metadata

- **Infrastructure Deployment Name:** `k3d-idp-demo-argocd-v2`
- **Platform Automation Tool:** Terraform (>= 1.5.0)
- **Package Manager:** Helm Provider
- **Target Cluster:** Local K3d Cluster (WSL2 Architecture)
- **Platform Owner:** Platform Engineering Team

---

## 🗂️ Project Structure

```text
├── README.md          # Infrastructure operational runbook and documentation
└── main.tf            # Core Terraform manifest managing the Helm platform release
```

---

## ⚙️ Prerequisites & Workstation Setup

Before executing this infrastructure automation suite, ensure your local workstation distribution has the following tools installed and active:

1. **Terraform CLI** configured in your global path environment.
2. An active **K3d Kubernetes Cluster** running with a local master node context.
3. Your local cluster configuration file accessible at the default path `~/.kube/config`.

---

## 🚀 Infrastructure Execution Runbook

Follow this exact sequential workflow in your terminal to initialize the providers and apply the resource configurations to your cluster:

```bash
# 1. Initialize the working directory and download required Helm providers
terraform init

# 2. Generate and review the execution plan to validate cluster mutations
terraform plan

# 3. Apply the infrastructure changes automatically to your K3d cluster
terraform apply -auto-approve
```

---

## 🔐 Post-Deployment Tasks: Accessing the Admin Console

Once Terraform returns an `Apply complete!` status, your core platform components will be initializing inside the cluster database. 

### 1. Verify Deployment Pod Status
Wait until all orchestrator pods reach a stable `Running` status using your cluster tool setup:
```bash
kubectl get pods -n k3d-idp-demo-argocd-v2
```

### 2. Extract the Default Admin Password
The system automatically generates a secure cryptographic string for the primary administrator account (`admin`). Run this command to decode the secret string directly from your terminal:
```bash
kubectl -n k3d-idp-demo-argocd-v2 get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

### 3. Open the Dashboard Interface
Open your favorite web browser on **Windows 11 Pro** and navigate to your local host mapping target port:
👉 **`http://localhost:8080`** *(Ensure your cluster Ingress or Service target mappings are active).*
