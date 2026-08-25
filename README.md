# 🏗️ k3d-idp-demo-argocd-v2-infra

This repository contains the automated **Infrastructure as Code (IaC)** blueprints provisioned by **Backstage IDP** to orchestrate core platform components inside your local **K3d cluster** using **Terraform and Helm** [INDEX].

---

## 📋 Infrastructure Metadata

- **Infrastructure Deployment Name:** `k3d-idp-demo-argocd-v2`
- **Platform Automation Tool:** Terraform (>= 1.5.0)
- **Package Manager:** Helm Provider
- **Target Cluster:** Local K3d Cluster (WSL2 Architecture)
- **Platform Owner:** Platform Engineering Team
- **GitHub Account:** @elserhumano

---

## 🗂️ Project Structure

```text
├── README.md          # Infrastructure operational runbook and documentation
└── main.tf            # Core Terraform manifest managing the Helm platform release
```

---

## 🚀 Infrastructure Execution Runbook

Follow this exact sequential workflow in your terminal to initialize the providers and apply the resource configurations to your cluster [INDEX]:

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

Once Terraform returns an `Apply complete!` status, your core platform components will be initializing inside the cluster database [INDEX].

### 1. Verify Deployment Pod Status
Wait until all orchestrator pods reach a stable `Running` status using your cluster tool setup:
```bash
kubectl get pods -n k3d-idp-demo-argocd-v2
```

### 2. Extract the Default Admin Password
ArgoCD generates a secure cryptographic string for the primary administrator account (`admin`) [INDEX]. Run this command to decode the secret string directly from your terminal:
```bash
kubectl -n k3d-idp-demo-argocd-v2 get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

### 3. Open the Dashboard Interface (WSL2 Port-Forward Tunnel)
Because this setup runs locally inside WSL2, execute a network port-forward tunnel in a secondary terminal tab to expose the service to your **Windows 11 Pro** host machine [INDEX]:
```bash
kubectl port-forward svc/k3d-idp-demo-argocd-v2-server -n k3d-idp-demo-argocd-v2 8081:80 --address 0.0.0.0
```

Now, open your favorite web browser and navigate to:
👉 **`http://localhost:8081`**

- **Username:** `admin` [INDEX]
- **Password:** The decoded string from the previous step [INDEX].
