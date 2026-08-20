# main.tf - Automated Infrastructure Blueprint for ArgoCD Deployment
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12.0"
    }
  }
}

# Configure the Helm provider targeting the local cluster context
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

# Dynamically provision the ArgoCD Release instance
resource "helm_release" "k3d-idp-demo-argocd-v2" {
  name             = "k3d-idp-demo-argocd-v2"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.53.1"
  namespace        = "k3d-idp-demo-argocd-v2"
  create_namespace = true

  # Expose the server via NodePort for local host machine connectivity
  set {
    name  = "server.service.type"
    value = "NodePort"
  }

  # Bypass internal SSL validation routines for development environments
  set {
    name  = "server.insecure"
    value = "true"
  }
}
